require("image").setup({
    max_width_window_percentage = math.huge,
    max_height_window_percentage = math.huge,
})

local zoom = 1.0
local base = 40

local function apply()
    local images = require("image").get_images()
    if #images == 0 then return end
    local w = math.max(1, math.floor(base * zoom))
    for _, img in ipairs(images) do
        local g = img.geometry or {}
        img:render({ x = g.x or 0, y = g.y or 0, width = w })
    end
end

local function step(f)
    zoom = math.min(20, math.max(0.1, zoom * f))
    apply()
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    group = vim.api.nvim_create_augroup("ImageZoomKeys", { clear = true }),
    pattern = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif", "*.bmp" },
    callback = function(ev)
        zoom = 1.0
        vim.keymap.set("n", "<leader>ii", function() step(1.25) end, { desc = "Zoom IN", buffer = ev.buf })
        vim.keymap.set("n", "<leader>io", function() step(0.8) end, { desc = "Zoom OUT", buffer = ev.buf })
        vim.keymap.set("n", "<leader>ir", function()
            zoom = 1.0; apply()
        end, { desc = "Zoom Reset", buffer = ev.buf })
    end,
})
