local java_cmds = vim.api.nvim_create_augroup('java_cmds', { clear = true })
local cache_vars = {}

local jdtls = require('jdtls')

local root_markers = {
    '.git',
    'mvnw',
    'gradlew',

    -- 'pom.xml',
    -- 'build.gradle',
}

local features = {
    codelens = true,
    debugger = true,
    springboot = true,
}

local function get_jdtls_paths()
    if cache_vars.paths then
        return cache_vars.paths
    end

    local mason_packages = vim.fn.stdpath('data') .. '/mason/packages'
    local jdtls_install = mason_packages .. '/jdtls'

    local path = {}
    path.lombok = jdtls_install .. '/lombok.jar'
    path.launcher_jar = vim.fn.glob(jdtls_install .. '/plugins/org.eclipse.equinox.launcher_*.jar')

    local home

    if vim.fn.has('unix') == 1 then
        home = os.getenv("HOME")
        path.platform_config = jdtls_install .. '/config_linux'
    elseif vim.fn.has('win32') == 1 then
        home = os.getenv("USERPROFILE")
        path.platform_config = jdtls_install .. '/config_win'
        if home then home = home:gsub('\\', '/') end
    end

    if not home then
        vim.notify("Could not determine home directory for JDTLS workspace.", vim.log.levels.ERROR)
        return nil
    end

    path.workspace_dir = home .. '/jdtls-workspaces'
    path.bundles = {}

    ---
    -- Include java-debug-adapter bundle if present
    ---
    local java_debug_path = mason_packages .. '/java-debug-adapter'
    local java_debug_jar = vim.fn.glob(java_debug_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar', true)

    if java_debug_jar ~= '' then
        table.insert(path.bundles, java_debug_jar)
    end

    ---
    -- Include java-test bundle if present
    ---

    -- local java_test_path = require('mason-registry')
    --     .get_package('java-test')
    --     :get_install_path()

    -- local java_test_bundle = vim.split(
    --   vim.fn.glob(java_test_path .. '/extension/server/*.jar'),
    --   '\n'
    -- )

    -- hardcoded path because mason doesn't have java-test 0.43.1 which fixes testing issues in nvim-jdtls
    -- clone the repo from vscode-java-test, 'npm install' and then 'npm run build-plugin'
    -- after that you'll see the server directory which contains all the jars (bundles) needed
    local java_test_bundle = vim.split(
        vim.fn.glob(home .. '/vscode-java-test-0.43.1/server/*.jar'),
        '\n'
    )

    if java_test_bundle[1] ~= '' then
        vim.list_extend(path.bundles, java_test_bundle)
    end

    -- Add springboot support
    if features.springboot then
        -- Do something here for springboot I guess
    end

    ---
    -- Useful if you're starting jdtls with a Java version that's
    -- different from the one the project uses.
    ---

    if vim.fn.has('unix') == 1 then
        path.runtimes = {
            {
                name = "JavaSE-21",
                path = home .. "/.sdkman/candidates/java/21.0.7-tem",
            },
            {
                name = "JavaSE-17",
                path = home .. "/.sdkman/candidates/java/17.0.15-tem",
                default = true,
            },
            {
                name = "JavaSE-11",
                path = home .. "/.sdkman/candidates/java/11.0.27-tem",
            },
        }
    elseif vim.fn.has('win32') == 1 then
        path.runtimes = {
            {
                name = "JavaSE-21",
                path = "C:/Program Files/Java/jdk-21/",
            },
            {
                name = "JavaSE-17",
                path = "C:/Program Files/Java/jdk-17/",
                default = true,
            },
        }
    end

    cache_vars.paths = path

    return path
end

local function enable_codelens(bufnr)
    pcall(vim.lsp.codelens.refresh)
    vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave' }, {
        buffer = bufnr,
        group = java_cmds,
        desc = 'Refresh Codelens',
        callback = function()
            pcall(vim.lsp.codelens.refresh)
        end,
    })
end

local function enable_debugger(bufnr)
    jdtls.setup_dap({ hotcodereplace = 'auto' })
    require('jdtls.dap').setup_dap_main_class_configs()
end

local function jdtls_on_attach(client, bufnr)
    if features.codelens then enable_codelens(bufnr) end
    if features.debugger then enable_debugger(bufnr) end

    local test_opts = {
        config = {
            console = 'internalConsole',
        },
        config_overrides = {
            shortenCommandLine = 'argfile',
        }
    }

    local function map(mode, keybind, command, opts)
        vim.keymap.set(mode, keybind, command, opts)
    end

    map("n", "<leader>jo", function() jdtls.organize_imports() end, { desc = "Organize Imports", noremap = true })
    map("n", "<leader>ju", function() jdtls.update_project_config() end, { desc = "Refresh Project Config", noremap = true })

    -- Refactoring
    map("n", "<leader>jev", function() jdtls.extract_variable() end, { desc = "Variable", noremap = true })
    map("n", "<leader>jec", function() jdtls.extract_constant() end, { desc = "Constant", noremap = true })
    map("n", "<leader>jem", function() jdtls.extract_method(true) end, { desc = "Method", noremap = true })

    -- Refactoring in Visual Mode
    map("v", "<leader>jev", function() jdtls.extract_variable() end, { desc = "Variable", noremap = true })
    map("v", "<leader>jec", function() jdtls.extract_constant() end, { desc = "Constant", noremap = true })
    map("v", "<leader>jem", function() jdtls.extract_method(true) end, { desc = "Method", noremap = true })

    -- Commands
    map("n", "<leader>jr", "<cmd>JdtSetRuntime<cr>", { desc = "Set Java Runtime", noremap = true })
    map("n", "<leader>jc", "<cmd>JdtCompile<cr>", { desc = "Compile Project", noremap = true })

    -- Testing
    map("n", "<leader>jtp", function() jdtls.pick_test(test_opts) end, { desc = "Pick Method", noremap = true })
    map("n", "<leader>jtm", function() jdtls.test_nearest_method(test_opts) end, { desc = "Method", noremap = true })
    map("n", "<leader>jtc", function() jdtls.test_class(test_opts) end, { desc = "Class", noremap = true })
end

local function jdtls_setup()
    local path = get_jdtls_paths()
    if not path then
        vim.notify("Failed to get JDTLS paths. JDTLS setup aborted.", vim.log.levels.ERROR)
        return {}
    end

    local workspace_dir = path.workspace_dir .. '/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    local project_root_dir = jdtls.setup.find_root(root_markers)

    -- LSP capabilities to override
    local capabilities = {}
    capabilities = require("utils.lsp").setup_capabilities(capabilities)

    -- Disable JDTLS snippets
    capabilities.textDocument.completion.completionItem.snippetSupport = false

    -- JDTLS capabilities
    jdtls.extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

    local cmd = {
        'java',

        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',

        -- '-Dlog.protocol=true',
        '-Dlog.level=INFO',

        '-javaagent:' .. path.lombok,
        '--add-modules=ALL-SYSTEM',
        '--add-opens',
        'java.base/java.util=ALL-UNNAMED',
        '--add-opens',
        'java.base/java.lang=ALL-UNNAMED',

        '-jar',
        path.launcher_jar,

        '-configuration',
        path.platform_config,

        '-data',
        workspace_dir,
    }

    local settings = {
        java = {
            jdt = {
                ls = {
                    -- You can define the java home especially for the JDTLS server here. In this way it doesn't matter what is your JAVA_HOME environmental variable anymore.
                    -- Convenient to solve version mismatches for some old projects
                    java = { home = path.runtimes[1].path },
                    vmargs =
                    "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx4G -Xms256m"
                }
            },
            server = {
                launchMode = "Hybrid",
            },
            edit = {
                validateAllOpenBuffersOnChanges = true,
            },
            diagnostic = {
                filter = {
                    "**/target",
                }
            },
            maxConcurrentBuilds = 1,
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = 'interactive',
                runtimes = path.runtimes,
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            saveActions = {
                organizeImports = false,
            },
            inlayHints = {
                parameterNames = {
                    enabled = 'all',
                },
            },
            format = {
                enabled = true,
                settings = {
                    profile = vim.fn.stdpath("config") .. '/format-styles/eclipse-java-format.xml',
                },
            }
        },
        signatureHelp = {
            enabled = true,
        },
        completion = {
            favoriteStaticMembers = {
                'org.hamcrest.MatcherAssert.assertThat',
                'org.hamcrest.Matchers.*',
                'org.hamcrest.CoreMatchers.*',
                'org.junit.jupiter.api.Assertions.*',
                'java.util.Objects.requireNonNull',
                'java.util.Objects.requireNonNullElse',
                'org.mockito.Mockito.*',
            },
            filteredTypes = {
                "com.sun.*",
                "io.micrometer.shaded.*",
                "java.awt.*",
                "jdk.*",
                "sun.*",
            },
            guessMethodArguments = true,
        },
        contentProvider = {
            preferred = 'fernflower',
        },
        extendedClientCapabilities = jdtls.extendedClientCapabilities,
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            }
        },
        codeGeneration = {
            toString = {
                template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
            },
            useBlocks = true,
        },
    }

    jdtls.start_or_attach({
        cmd = cmd,
        settings = settings,
        on_attach = jdtls_on_attach,
        capabilities = capabilities,
        root_dir = project_root_dir,
        flags = {
            allow_incremental_sync = true,
        },
        init_options = {
            bundles = path.bundles,
        },
    })
end

jdtls_setup()
