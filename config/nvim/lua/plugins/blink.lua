return {
    "saghen/blink.cmp",
    version = "1.*",
    opts = {
        keymap = {
            preset = "default", -- C-p/C-n C-y
        },
        appearance = { nerd_font_variant = "mono" },
        signature = {
            enabled = true,
            window = {
                show_documentation = true,
            },
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
        completion = {
            trigger = {
                prefetch_on_insert = false,
                show_on_insert = false,
                show_on_keyword = false,
                show_on_backspace_in_keyword = false,
            },
        },
    },
    opts_extend = { "sources.default" },
}
