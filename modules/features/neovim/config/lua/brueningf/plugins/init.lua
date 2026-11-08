return {

    {
        "nvim-lua/plenary.nvim",
        name = "plenary"
    },

    { 'rstacruz/vim-closer',       lazy = true },

    -- Colorscheme
    {
        'rose-pine/neovim',
        lazy = false,
        priority = 1000,
        config = function()
            -- load the colorscheme here
            vim.cmd([[colorscheme rose-pine]])
        end,
    },

    { 'nvim-orgmode/orgmode',      opts = {} },

    -- Harpoon
    {
        'ThePrimeagen/harpoon',
        config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            vim.keymap.set("n", "<leader>a", mark.add_file)
            vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

            vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
            vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
            vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
            vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)
        end
    },

    -- Vim Be Good
    { 'ThePrimeagen/vim-be-good' },

    -- Undotree
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
        end
    },
    -- Toit language
    {
        "toitware/ide-tools",
        ft = { "toit" },
        config = function(plugin)
            vim.opt.rtp:append(plugin.dir .. "/start/vim")
        end,
        init = function(plugin)
            require("lazy.core.loader").ftdetect(plugin.dir .. "/start/vim")
        end,
    },

    -- Not so important stuff
    { "nvim-tree/nvim-web-devicons", lazy = true },

    { "github/copilot.vim" },
}
