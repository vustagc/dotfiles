return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-mini/mini.icons" },
    ---@module "fzf-lua"
    ---@type fzf-lua.Config|{}
    ---@diagnostic disable: missing-fields
    opts = {
        keymap = {
            fzf = {
                ["ctrl-a"] = "select-all",
                ["ctrl-q"] = "accept",
            },
        },
    }

    ---@diagnostic enable: missing-fields
}
