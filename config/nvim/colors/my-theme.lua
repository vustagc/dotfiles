local M = {}

-- --- Accent colors
M.accents = {
    red = "#E85A4F",
    coral = "#FF6B6B",
    rose = "#FF758F",
    pink = "#E57AA4",
    lavender = "#C9A0FF",
    violet = "#A998F0",
    blue = "#87afd7",
    cyan = "#64B8B4",
    mint = "#7CE0C2",
    green = "#5FB36A",
    lime = "#9ACD5A",
    yellow = "#F6CE4E",
    peach = "#FFB07C",
    orange = "#FF8E29",
}

--- @class Colors
M.colors = {
    background = "#1d1d1f",
    foreground = "#E6E6E6",
    accent = "#87afd7",
    highlight = "#404040",
    unselected = "#707070",
    selected = "#A6A6A6",
    constant = "#ffafaf",
    string = "#FFB07C", -- #5FB36A
    comment = "#808080",

    --
    diff_add = "#273C29",
    diff_change = "#4D4322",
    diff_delete = "#492523",
    diff_text = "#857131",
}

--- Convenience `vim.api.nvim_set_hl()` wrapper
--- @param name string
--- @param val vim.api.keyset.highlight
local function hl(name, val)
    vim.api.nvim_set_hl(0, name, val)
end

function M.colorscheme()
    vim.o.background = "dark"
    vim.g.colors_name = "silentium"
    vim.cmd.highlight("clear")
    if vim.fn.has("syntax_on") then
        vim.cmd.syntax("reset")
    end

    hl("@constant.html", { fg = M.colors.selected })
    hl("@tag", { bg = nil, fg = M.colors.accent })
    hl("@tag.attribute", { bg = nil, fg = M.colors.foreground })
    hl("@tag.builtin", { bg = nil, fg = M.colors.accent })
    hl("@tag.delimiter", { bg = nil, fg = M.colors.foreground })
    hl("@variable", { bg = nil, fg = M.colors.foreground })
    hl("Added", { fg = M.accents.green })
    hl("Changed", { fg = M.accents.yellow })
    hl("ColorColumn", { bg = M.colors.highlight })
    hl("CursorColumn", { bg = M.colors.highlight })
    hl("Comment", { fg = M.colors.comment })
    hl("Conceal", { fg = M.colors.highlight })
    hl("Constant", { fg = M.colors.constant })
    hl("CursorColumn", { bg = M.colors.highlight })
    hl("CursorLine", { bg = M.colors.highlight })
    hl("Delimiter", { bg = nil })
    hl("DiagnosticError", { fg = M.accents.red })
    hl("DiagnosticHint", { fg = M.accents.blue })
    hl("DiagnosticInfo", { fg = M.accents.cyan })
    hl("DiagnosticOk", { fg = M.accents.green })
    hl("DiagnosticUnderlineError", { underline = true, sp = M.accents.red })
    hl("DiagnosticUnderlineHint", { underline = true, sp = M.accents.blue })
    hl("DiagnosticUnderlineInfo", { underline = true, sp = M.accents.cyan })
    hl("DiagnosticUnderlineOk", { underline = true, sp = M.accents.green })
    hl("DiagnosticUnderlineWarn", { underline = true, sp = M.accents.yellow })
    hl("DiagnosticWarn", { fg = M.accents.yellow })
    hl("DiffAdd", { bg = M.colors.diff_add })
    hl("DiffChange", { bg = M.colors.diff_change })
    hl("DiffDelete", { bg = M.colors.diff_delete })
    hl("DiffText", { bg = M.colors.diff_text })
    hl("Directory", { fg = M.colors.accent })
    hl("Error", { bg = M.accents.red })
    hl("ErrorMsg", { fg = M.accents.red })
    hl("FloatShadow", { bg = M.colors.highlight })
    hl("FloatShadowThrough", { bg = M.colors.highlight })
    hl("Folded", { bg = M.colors.highlight, fg = M.colors.unselected })
    hl("Function", { bg = nil})
    hl("Identifier", { bg = nil })
    hl("Keyword", { bg = nil, fg = M.colors.accent })
    hl("Define", { bg = nil })
    hl("CursorLineNr", { fg = M.colors.selected })
    hl("LineNr", { fg = M.colors.selected })
    hl("LineNrBelow", { fg = M.colors.unselected })
    hl("LineNrAbove", { fg = M.colors.unselected })
    hl("MatchParen", { bg = M.colors.highlight })
    hl("ModeMsg", { fg = M.accents.green })
    hl("MoreMsg", { fg = M.accents.blue })
    hl("NonText", { fg = M.colors.highlight })
    hl("Normal", { bg = M.colors.background, fg = M.colors.foreground })
    hl("NormalFloat", { bg = M.colors.highlight })
    hl("OkMsg", { fg = M.accents.green })
    hl("Pmenu", { bg = M.colors.highlight })
    hl("Tag", { bg = nil })
    hl("Type", { bg = nil })
    -- hl("PmenuMatch", { bg = M.colors.highlight, fg = M.colors.constant })
    hl("PmenuMatchSel", { bg = M.colors.selected })
    hl("PmenuSel", { bg = M.colors.selected })
    hl("PmenuThumb", { bg = M.colors.unselected })
    hl("PmenuExtra", { bg = M.colors.highlight })
    hl("PmenuExtraSel", { bg = M.colors.selected })

    hl("LspReferenceTarget", { bg = M.colors.highlight})
    hl("LspInlayHint", { bg = M.colors.highlight})
    hl("LspCodeLens", { bg = M.colors.highlight})
    hl("MessageWindow", { link = "Pmenu" })
    hl("Question", { fg = M.colors.accent })
    hl("QuickFixLine", { bg = M.colors.highlight })
    hl("Removed", { fg = M.accents.red })
    hl("SignColumn", { fg = M.colors.selected })
    hl("Debug", { bg = nil })
    hl("Tag", { bg = nil })
    hl("Typedef", { bg = nil })
    hl("Special", { bg = nil })
    hl("SpecialChar", { bg = nil })
    hl("SpecialComment", { bg = nil })
    hl("SpecialKey", { bg = nil, fg = M.colors.highlight })
    hl("SpellBad", { undercurl = true, sp = M.accents.red })
    hl("SpellCap", { undercurl = true, sp = M.accents.yellow })
    hl("SpellLocal", { undercurl = true, sp = M.accents.green })
    hl("SpellRare", { undercurl = true, sp = M.accents.blue })
    hl("Statement", { bg = nil, fg = M.colors.accent })
    hl("Conditional", { bg = nil, fg = M.colors.accent })
    hl("Exception", { bg = nil, fg = M.colors.accent })
    hl("Label", { bg = nil, fg = M.colors.accent })
    -- hl("Repeat", { bg = nil, fg = M.colors.accent })
    hl("Operator", { bg = nil })
    hl("StatusLine", { bg = M.colors.highlight, fg = M.colors.foreground })
    hl("StatusLineNC", { bg = M.colors.highlight, fg = M.colors.foreground })
    hl("String", { fg = M.colors.string })
    hl("TabLine", { bg = M.colors.highlight })
    hl("TabLineSel", { bg = M.colors.background })
    hl("Title", { bg = nil, fg = M.colors.foreground })
    hl("Todo", { bg = nil, fg = M.colors.foreground })
    hl("Visual", { bg = M.colors.highlight })
    hl("WarningMsg", { fg = M.accents.yellow })
    hl("WinBar", { bg = M.colors.accent, fg = M.colors.highlight })
    hl("WinBarNC", { bg = M.colors.accent, fg = M.colors.highlight })
    hl("WinSeparator", { fg = M.colors.unselected })

    -- markdownCode
    -- markdownCodeBlock
    -- markdownH1
    -- markdownH2
    -- markdownH3
    -- markdownH4
    -- markdownH5
    -- markdownH6
    -- markdownHeadingDelimiter
    -- markdownLinkText

    vim.g.terminal_color_0 = M.colors.highlight
    vim.g.terminal_color_1 = M.accents.red
    vim.g.terminal_color_2 = M.accents.green
    vim.g.terminal_color_3 = M.accents.yellow
    vim.g.terminal_color_4 = M.accents.blue
    vim.g.terminal_color_5 = M.accents.pink
    vim.g.terminal_color_6 = M.accents.cyan
    vim.g.terminal_color_7 = M.colors.foreground
    vim.g.terminal_color_8 = M.colors.unselected
    vim.g.terminal_color_9 = "#FF6A6A"
    vim.g.terminal_color_10 = "#7AD48A"
    vim.g.terminal_color_11 = "#FFE07A"
    vim.g.terminal_color_12 = "#7FA2E6"
    vim.g.terminal_color_13 = "#F29BC1"
    vim.g.terminal_color_14 = "#7FD9D4"
    vim.g.terminal_color_15 = "#FFFFFF"
end

--- Configure colorscheme
--- @param colors? Colors
function M.setup(colors)
    if colors ~= nil then
        M.colors = vim.tbl_extend("force", M.colors, colors)
    end
end

M.colorscheme()

return M
