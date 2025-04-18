local java_cmds = vim.api.nvim_create_augroup('java_cmds', { clear = true })
local cache_vars = {}

local root_markers = {
  '.git', -- These markers are preferred for the best root project recognition.
  'mvnw',
  'gradlew',

  -- Otherwise, you can use these root markers to identify your project also
  -- 'pom.xml',
  -- 'build.gradle',
}

local features = {
  codelens = false,
  debugger = true,
}

local function get_jdtls_paths()
  if cache_vars.paths then
    return cache_vars.paths
  end

  local path = {}

  local home = os.getenv("USERPROFILE")

  -- Be consistent with the slashes
  if home then
    home = home:gsub('\\', '/')
  end

  -- path.workspace_dir = vim.fn.stdpath('cache') .. '/nvim-jdtls'
  path.workspace_dir = home .. '/nvim-jdtls'

  local jdtls_install = require('mason-registry')
      .get_package('jdtls')
      :get_install_path()

  path.lombok = jdtls_install .. '/lombok.jar'
  path.launcher_jar = vim.fn.glob(jdtls_install .. '/plugins/org.eclipse.equinox.launcher_*.jar')

  if vim.fn.has('mac') == 1 then
    path.platform_config = jdtls_install .. '/config_mac'
  elseif vim.fn.has('unix') == 1 then
    path.platform_config = jdtls_install .. '/config_linux'
  elseif vim.fn.has('win32') == 1 then
    path.platform_config = jdtls_install .. '/config_win'
  end

  path.bundles = {}

  ---
  -- Include java-debug-adapter bundle if present
  ---
  local java_debug_path = require('mason-registry')
      .get_package('java-debug-adapter')
      :get_install_path()

  local java_debug_jar = vim.fn.glob(java_debug_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar', 1)

  if java_debug_jar ~= '' then
    table.insert(path.bundles, java_debug_jar)
  end

  ---
  -- Include java-test bundle if present
  ---
  local java_test_path = require('mason-registry')
      .get_package('java-test')
      :get_install_path()

  local java_test_bundle = vim.split(
    vim.fn.glob(java_test_path .. '/extension/server/*.jar'),
    '\n'
  )

  if java_test_bundle[1] ~= '' then
    vim.list_extend(path.bundles, java_test_bundle)
  end

  ---
  -- Useful if you're starting jdtls with a Java version that's
  -- different from the one the project uses.
  ---
  path.runtimes = {
    -- Note: the field `name` must be a valid `ExecutionEnvironment`,
    -- you can find the list here:
    -- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    --
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

  cache_vars.paths = path

  return path
end

local function enable_codelens(bufnr)
  pcall(vim.lsp.codelens.refresh)

  vim.api.nvim_create_autocmd({'BufEnter', 'InsertLeave'}, {
    buffer = bufnr,
    group = java_cmds,
    desc = 'refresh codelens',
    callback = function()
      pcall(vim.lsp.codelens.refresh)
    end,
  })
end

local function enable_debugger(bufnr)
  require('jdtls').setup_dap({ hotcodereplace = 'auto' })

  -- You don't need this if you configure manually the DAP in dap.lua
  require('jdtls.dap').setup_dap_main_class_configs()
end

local function jdtls_on_attach(client, bufnr)
  if features.codelens then
    enable_codelens(bufnr)
  end

  if features.debugger then
    enable_debugger(bufnr)
  end
end

local basic_capabilities = {
  textDocument = {
    completion = {
      completionItem = {
        snippetSupport = true
      }
    }
  }
}

local function jdtls_setup()
  local jdtls = require('jdtls')

  local path = get_jdtls_paths()

  local workspace_dir = path.workspace_dir .. '/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
  local project_root_dir = require('jdtls.setup').find_root(root_markers)

  -- Be consistent with the slashes, because for some reason
  -- find_root() SOMETIMES returns path with backwards slash \
  -- too lazy to fix properly so just format everything from \ to /
  if project_root_dir then
    project_root_dir = project_root_dir:gsub('\\', '/')
  end

  if cache_vars.capabilities == nil then
    jdtls.extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
  end

  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
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

  local lsp_settings = {
    java = {
      jdt = {
        ls = {
          -- You can define the java home especially for the JDTLS server here. In this way it doesn't matter what is your JAVA_HOME environmental variable anymore.
          -- Convenient to solve version mismatches for some old projects
          java = { home = "C:/Program Files/Java/jdk-21/" },
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
      project = {
        resourceFilters = {
          ".git",
          "node_modules",
        },
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
          profile = 'C:/Users/crme107/AppData/Local/nvim/format-styles/eclipse-java-format.xml',
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

  -- This starts a new client & server,
  -- or attaches to an existing client & server depending on the `root_dir`.
  jdtls.start_or_attach({
    cmd = cmd,
    settings = lsp_settings,
    on_attach = jdtls_on_attach,
    capabilities = basic_capabilities,
    root_dir = project_root_dir,
    flags = {
      allow_incremental_sync = true,
    },
    init_options = {
      bundles = path.bundles,
    },
  })
end

vim.api.nvim_create_autocmd('FileType', {
  group = java_cmds,
  pattern = { 'java' },
  desc = 'Setup JDTLS',
  callback = jdtls_setup,
})
