local opt = vim.opt
local map = vim.keymap.set
local set_hl = vim.api.nvim_set_hl

-- variables
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- vim.g.zig_fmt_parse_errors = 0
-- vim.g.zig_fmt_autosave = 0

-- this is actually the culprit most likely,
-- does risk some data loss, but worth it for immediate writes
vim.opt.fsync = false

-- options
--opt.netrw = false
vim.opt.statuscolumn = "%=%{v:relnum == 0 ? v:lnum : v:relnum} "
-- vim.opt.statuscolumn = ""
opt.encoding = "utf-8"
opt.background = "dark"
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.numberwidth = 4
--opt.signcolumn = "no"
opt.showtabline = 2
opt.cursorline = false
opt.showmode = false
opt.splitright = true
opt.splitbelow = true
opt.wrap = false
opt.mouse = "a"
opt.hidden = true
opt.updatetime = 300
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.ignorecase = true
opt.smartcase = true
opt.scrolloff = 0
opt.sidescrolloff = 0
opt.laststatus = 2
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undofile = true
-- vim.opt.shadafile = "NONE"
--opt.guicursor = "n-v-c:block,i-ci:ver25,r-cr:hor20,t:ver25"

-- variables
vim.diagnostic.config({
    virtual_text = false,
    signs = false,
    underline = false,
    update_in_insert = false,
})

vim.cmd("colorscheme my-theme")

-- keybinds
vim.cmd("tnoremap <C-q> <C-\\><C-n>")
map("n", "<C-s>", function()
    vim.lsp.buf.format({ async = false })
    vim.cmd('wa')
end, { silent = true })

-- clipboard
map("v", "<C-y>", '"+y', { silent = true })
map("n", "<C-p>", '"+p', { silent = true })
-- window nav
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
-- buffer nav
map("n", "<leader>bh", ":bprevious<CR>")
map("n", "<leader>bl", ":bnext<CR>")
-- tab nav
map("n", "<leader>tT", ":-tabnew<CR>")
map("n", "<leader>tt", ":tabnew<CR>")
map("n", "<leader>th", ":tabprev<CR>")
map("n", "<leader>tl", ":tabnext<CR>")
map("n", "<leader>tq", ":tabclose<CR>")
-- qf list
map("n", "<leader>cl", ":cnext<CR>")
map("n", "<leader>ch", ":cprev<CR>")
map("n", "<leader>cc", ":belowright copen<CR>")
map("n", "<leader>cq", ":cclose<CR>")
-- notes
map("n", "<leader>ot", ":0tabnew ~/Notes/Todos/todo.md <CR>")
map("n", "<leader>on", ":tabnew ~/Notes/")
-- scratch buffer
map("n", "<leader>x", ":lua Snacks.scratch()<CR>")
-- plugin keybinds
map("n", "<leader>.", ":lua MiniFiles.open()<CR>")
map("n", "<leader>ss", "<cmd>AerialToggle left<CR>") -- symbol search
-- repl
map("n", "<leader>rs", ":vs<CR>:vert res 70<CR>:IronReplHere<CR>") -- start
map("n", "<leader>rr", ":IronSend :l %<CR>") -- reload
map("n", "<leader>rl", ":lua require('iron.core').send_line()<CR><Esc>")
map("v", "<leader>rl", ":lua require('iron.core').visual_send()<CR><Esc>")

map("n", "<leader>rp", ":lua require('iron.core').repl_here(python)<CR><Esc>") -- floating python repl

local user_cmd = vim.api.nvim_create_user_command
user_cmd("Odin", function() require("user.odin").build(opts) end, {})
user_cmd("Note", function(opts) require("user.commands").makeNote(opts) end, { nargs = "?" })
user_cmd("Mtmp", function() require("user.commands").mktemp() end, {})
-- :read !ls        # paste ouput from command
-- <range>write !wc # write output to command

-- Auto commands
local auto_cmd = vim.api.nvim_create_autocmd
auto_cmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        local opts = { buffer = ev.buf }
        map("n", "gd", vim.lsp.buf.definition, opts)
        -- map("n", "gs", goto_definition_vsplit)
        map("n", "gr", vim.lsp.buf.references, opts)
        map("n", "gh", vim.lsp.buf.hover, opts)
        map("n", "<leader>ih", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, opts)
    end,
})

auto_cmd("CursorMoved", {
    group = vim.api.nvim_create_augroup("auto-hlsearch", { clear = true }),
    callback = function()
        if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
            vim.schedule(function()
                vim.cmd.nohlsearch()
            end)
        end
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'odin',
    callback = function()
        map("n", "<leader>mb", ":Odin<CR>")         -- build
        map("n", "<leader>mt", ":!odin test .<CR>") -- test
        map("n", "<leader>mr", ":!odin run .<CR>")  -- run
    end,
})


vim.lsp.config('*', {
    root_markers = { '.git' },
})

-- lsp
vim.lsp.enable({
    "ols",
    "lua_ls",
    "zigscient",
    "clangd",
    "hls",
    "marskman",
})

-- plugins
vim.pack.add({
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/stevearc/aerial.nvim",
    "https://github.com/christoomey/vim-tmux-navigator",
    "https://github.com/jakewvincent/mkdnflow.nvim",
    "https://github.com/Vigemus/iron.nvim",

    --
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/nvim-mini/mini.files",
    "https://github.com/nvim-mini/mini-git",
    "https://github.com/nvim-mini/mini.pairs",
    "https://github.com/nvim-mini/mini.sessions",
    "https://github.com/nvim-mini/mini.surround",

    --
    "https://github.com/folke/zen-mode.nvim",
    "https://github.com/folke/snacks.nvim",
})
-- require('mini.icons').setup()
require('mini.surround').setup() -- `sa` in normal and visual modes to 'surround add', `sr` to replace
require('mini.files').setup()
require('mini.git').setup()
require('mini.pairs').setup()
require('mini.sessions').setup({
    autoread = true,
    autowrite = true,
    directory = "~/.sessions",
})

require("snacks").setup({ scratch = {
    enabled = true,
    ft = "lua"

} })

require("iron.core").setup({
    scratch_repl = true,
    repl_definition = {
        sh = {
            command = { "zsh" }
        },
        python = {
            command = { "python3" },
            format = require("iron.fts.common").bracketed_paste_python,
            block_dividers = { "# %%", "#%%" },
            env = { PYTHON_BASIC_REPL = "1" } --this is needed for python3.13 and up.
        },
        haskell = {
            command = function(meta)
                local filename = vim.api.nvim_buf_get_name(meta.current_bufnr)
                return { 'cabal', 'v2-repl', filename }
            end
        }
    },
    -- repl_open_cmd = require("iron.view").center("30%", 20) -- this shit does not wrk bruh
})

require("mkdnflow").setup({
    mappings = {
        MkdnNextLink = false,
        MkdnPrevLink = false,
        MkdnNextHeading = { 'n', ']]' },
        MkdnPrevHeading = { 'n', '[[' },
        MkdnFoldSection = { 'n', '<Tab>' },
        MkdnUnfoldSection = { 'n', '<S-Tab>' }, -- or just `l`
        MkdnToggleToDo = { { 'n', 'v' }, '<C-Space>' },
        MkdnEnter = { { 'n', 'v' }, '<CR>' },
        MkdnGoBack = { 'n', '<BS>' },
        MkdnTableNewRowBelow = { 'n', '<leader>ir' },
        MkdnTableNewRowAbove = { 'n', '<leader>iR' },
        MkdnTableNewColAfter = { 'n', '<leader>ic' },
        MkdnTableNewColBefore = { 'n', '<leader>iC' },
        MkdnTableNextCell = { 'i', '<Tab>' },
        MkdnTablePrevCell = { 'i', '<S-Tab>' },
    }
})

require("zen-mode").setup({
    plugins = {
        tmux = { enabled = true }, -- disables the tmux statusline
    }
})

require("aerial").setup({
    on_attach = function(bufnr)
        -- vim.keymap.set("n", "[[", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        -- vim.keymap.set("n", "]]", "<cmd>AerialNext<CR>", { buffer = bufnr })
    end,

    keymaps = {
        ["?"] = "actions.show_help",
        ["g?"] = "actions.show_help",
        ["."] = "actions.jump",
        ["<2-LeftMouse>"] = "actions.jump",
        ["<C-v>"] = "actions.jump_vsplit",
        ["<C-s>"] = "actions.jump_split",
        ["p"] = "actions.scroll",
        ["q"] = "actions.close",
    },

    icons = {},

    close_on_select = true,
    ignore = {
        unlisted_buffers = true,
        diff_windows = true,
        filetypes = { "oil", "org", "txt" },
    },

    layout = {
        width = 30,
        win_opts = {},
        default_direction = "prefer_left",
        placement = "window",
        resize_to_content = false,
    },

    attach_mode = "global",
})

-- native fuzzy finder with :find
-- https://cherryramatis.xyz/posts/native-fuzzy-finder-in-neovim-with-lua-and-cool-bindings/
if vim.fn.executable "rg" == 1 then
    function _G.RgFindFiles(cmdarg, _cmdcomplete)
        local fnames = vim.fn.systemlist('rg --files --hidden --color=never --glob="!.git"')
        if #cmdarg == 0 then
            return fnames
        else
            return vim.fn.matchfuzzy(fnames, cmdarg)
        end
    end

    vim.o.findfunc = 'v:lua.RgFindFiles'
end
local function is_cmdline_type_find()
    local cmdline_cmd = vim.fn.split(vim.fn.getcmdline(), ' ')[1]
    return cmdline_cmd == 'find' or cmdline_cmd == 'fin'
end
auto_cmd({ 'CmdlineChanged', 'CmdlineLeave' }, {
    pattern = { '*' },
    group = vim.api.nvim_create_augroup('CmdlineAutocompletion', { clear = true }),
    callback = function(ev)
        local function should_enable_autocomplete()
            local cmdline_cmd = vim.fn.split(vim.fn.getcmdline(), ' ')[1]
            return is_cmdline_type_find()
        end
        if ev.event == 'CmdlineChanged' and should_enable_autocomplete() then
            vim.opt.wildmode = 'noselect:lastused,full'
            vim.fn.wildtrigger()
        end
        if ev.event == 'CmdlineLeave' then
            vim.opt.wildmode = 'full'
        end
    end
})

-- Grep
vim.cmd("cabbrev grep Grep")
vim.o.grepprg = "rg --vimgrep --hidden -g '!.git/*'"
vim.api.nvim_create_user_command('Grep', function(opts)
    local pattern = vim.trim(opts.args)

    if pattern == '' then
        return
    end

    local grep_cmd = vim.o.grepprg .. ' ' .. vim.fn.shellescape(pattern)
    local grep_output = vim.fn.systemlist(grep_cmd)

    if #grep_output == 0 then
        print('No matches found for: ' .. pattern)
        return
    end

    -- Set and open quickfix list
    vim.fn.setqflist({}, ' ', {
        title = 'Grep results for: ' .. pattern,
        lines = grep_output
    })
    vim.cmd('belowright copen')
end, { nargs = 1 })
