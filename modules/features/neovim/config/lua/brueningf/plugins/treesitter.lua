return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local treesitter = require("nvim-treesitter")

        -- fga is not in nvim-treesitter's parser list. Register it before install
        -- so :TSInstall / treesitter.install() picks it up on TSUpdate.
        vim.api.nvim_create_autocmd("User", {
            pattern = "TSUpdate",
            callback = function()
                require("nvim-treesitter.parsers").fga = {
                    install_info = {
                        url = "https://github.com/matoous/tree-sitter-fga",
                        revision = "b17d4593107baea124197bc8a034579c90e9ff12",
                        queries = "queries",
                    },
                }
            end,
        })

        treesitter.install({
            "bash", "blade", "c", "dockerfile", "fga", "gitcommit", "gitignore",
            "gpg", "hcl", "html", "hurl", "ini", "javascript", "jsdoc", "json",
            "jsonnet", "lua", "make", "markdown", "nix", "php", "rust", "smithy",
            "sql", "templ", "terraform", "toml", "tsx", "typescript", "vim", "vimdoc",
            "yaml",
        })

        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("Treesitter", {}),
            callback = function(args)
                if not pcall(vim.treesitter.start, args.buf) then
                    return
                end

                vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

                if vim.bo[args.buf].filetype == "markdown" then
                    vim.bo[args.buf].syntax = "on"
                end
            end,
        })
    end
}
