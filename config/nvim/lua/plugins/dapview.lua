return {
    {
        "igorlfs/nvim-dap-view",
        lazy = false,
        ---@module 'dap-view'
        ---@type dapview.Config
        opts = {
            winbar = {
                show = true,
                sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl" },
                default_section = "watches",
                show_keymap_hints = true,
                base_sections = {
                    breakpoints = { label = "Breakpoints", keymap = "B" },
                    scopes = { label = "Scopes", keymap = "S" },
                    exceptions = { label = "Exceptions", keymap = "E" },
                    watches = { label = "Watches", keymap = "W" },
                    threads = { label = "Threads", keymap = "T" },
                    repl = { label = "REPL", keymap = "R" },
                    sessions = { label = "Sessions", keymap = "K" },
                    console = { label = "Console", keymap = "C" },
                },
                custom_sections = {},
                controls = {
                    enabled = false,
                    position = "right",
                    buttons = {
                        "play",
                        "step_into",
                        "step_over",
                        "step_out",
                        "step_back",
                        "run_last",
                        "terminate",
                        "disconnect",
                    },
                    custom_buttons = {},
                },
            },
            windows = {
                size = 0.5,
                position = "right",
                terminal = {
                    size = 0.5,
                    position = "left",
                    -- List of debug adapters for which the terminal should be ALWAYS hidden
                    hide = {},
                },
            },
            icons = {
                collapsed = "󰅂 ",
                disabled = "",
                disconnect = "",
                enabled = "",
                expanded = "󰅀 ",
                filter = "󰈲",
                negate = " ",
                pause = "",
                play = "",
                run_last = "",
                step_back = "",
                step_into = "",
                step_out = "",
                step_over = "",
                terminate = "",
            },
            help = {
                border = nil,
            },
            render = {
                sort_variables = nil,
                threads = {
                    format = function(name, lnum, path)
                        return {
                            { part = name, separator = " " },
                            { part = path, hl = "FileName",  separator = ":" },
                            { part = lnum, hl = "LineNumber" },
                        }
                    end,
                    align = false,
                },
                breakpoints = {
                    format = function(line, lnum, path)
                        return {
                            { part = path, hl = "FileName" },
                            { part = lnum, hl = "LineNumber" },
                            { part = line, hl = true },
                        }
                    end,
                    align = false,
                },
            },
            switchbuf = "usetab,uselast",
            auto_toggle = true,
            follow_tab = false,
        },
    },
}
