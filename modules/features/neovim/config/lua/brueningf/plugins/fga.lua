local server = vim.fn.expand("~/.local/share/openfga/vscode-ext/server/out/server.node.js")

return {
    "hedengran/fga.nvim",
    lazy = false,
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
    opts = function()
        if vim.fn.filereadable(server) ~= 1 then
            return {}
        end

        return {
            lsp_cmd = { "node", server, "--stdio" },
        }
    end,
    config = function(_, opts)
        require("fga").setup(opts)

        if not opts.lsp_cmd then
            return
        end

        vim.lsp.config("openfga", {
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })
    end,
}
