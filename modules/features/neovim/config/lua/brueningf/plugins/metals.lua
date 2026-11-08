return {
    "scalameta/nvim-metals",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    ft = { "scala", "sbt", "java" },
    opts = function()
        local metals_config = require("metals").bare_config()
        local cmp_lsp = require("cmp_nvim_lsp")

        -- The metals launcher spawns a JVM, so it needs java on PATH. macOS only
        -- ships a stub at /usr/bin/java, and Homebrew keeps its JDKs keg-only.
        local java_home = "/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"
        if vim.fn.isdirectory(java_home) == 1 then
            vim.env.JAVA_HOME = java_home
            vim.env.PATH = java_home .. "/bin:" .. vim.env.PATH
            metals_config.settings = { javaHome = java_home }
        end

        metals_config.capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        -- LSP keymaps live in the global LspAttach autocmd in lua/brueningf/init.lua
        metals_config.on_attach = function(_, _)
        end

        return metals_config
    end,
    config = function(self, metals_config)
        local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = self.ft,
            callback = function()
                require("metals").initialize_or_attach(metals_config)
            end,
            group = nvim_metals_group,
        })
    end,
}
