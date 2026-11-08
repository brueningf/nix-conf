local function float_height()
    return math.max(vim.o.lines - vim.o.cmdheight, 10)
end

local function apply_float_size(opts)
    opts.float.height = float_height()
    opts.float.row = 0
    opts.float.col = 0
end

-- Sessions are keyed by tool + cwd, but the built-in toggle reattaches any
-- running session, so after a sessionizer switch it reopens the previous
-- project. Only reuse a session started in this cwd; otherwise start one here.
local function project_cli(opts)
    opts = opts or {}
    local name = opts.name or "pi"
    local State = require("sidekick.cli.state")
    local cwd = require("sidekick.cli.session").cwd()

    for _, state in ipairs(State.get({ name = name })) do
        if state.session and state.session.cwd == cwd then
            if opts.toggle ~= false and state.terminal and state.terminal:is_open() then
                state.terminal:hide()
                return
            end
            State.attach(state, { show = true, focus = true })
            return
        end
    end

    State.attach({
        tool = require("sidekick.config").get_tool(name),
    }, { show = true, focus = true })
end

return {
    "folke/sidekick.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
    },
    opts = {
        cli = {
            picker = "telescope",
            win = {
                layout = "float",
                float = { width = 1, height = float_height(), row = 0, col = 0 },
                split = { width = 80, height = 20 },
                config = function(terminal)
                    apply_float_size(terminal.opts)
                    local open_win = terminal.open_win
                    function terminal:open_win()
                        apply_float_size(self.opts)
                        return open_win(self)
                    end
                end,
            },
            mux = {
                backend = "tmux",
                enabled = true,
            },
        },
    },
    config = function(_, opts)
        require("sidekick").setup(opts)
        -- NES uses Copilot LSP (copilot.vim still handles inline completions)
        vim.lsp.enable("copilot")
    end,
    keys = {
        {
            "<tab>",
            function()
                if not require("sidekick").nes_jump_or_apply() then
                    return "<Tab>"
                end
            end,
            expr = true,
            desc = "Goto/Apply Next Edit Suggestion",
        },
        {
            "<c-.>",
            function()
                require("sidekick.cli").focus()
            end,
            desc = "Sidekick Focus",
            mode = { "n", "t", "i", "x" },
        },
        {
            "<leader>cc",
            function()
                project_cli()
            end,
            desc = "Sidekick Toggle CLI",
        },
    },
}
