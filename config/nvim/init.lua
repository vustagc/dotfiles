local opt = vim.opt
local map = vim.keymap.set
local set_hl = vim.api.nvim_set_hl

-- variables
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.zig_fmt_parse_errors = 0
vim.g.zig_fmt_autosave = 0

vim.opt.statuscolumn = " "

-- options
opt.encoding = "utf-8"
opt.background = "dark"
opt.termguicolors = true
opt.number = false
-- opt.relativenumber = true
-- opt.signcolumn = "yes"
-- opt.showtabline = 2
-- opt.cursorline = true
opt.showmode = false
opt.splitright = true
opt.splitbelow = true
opt.wrap = false
opt.mouse = "a"
opt.hidden = true
opt.updatetime = 300
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.tabstop = 8
opt.shiftwidth = 4
opt.expandtab = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.scrolloff = 0
opt.sidescrolloff = 0
opt.laststatus = 0
opt.guicursor = "n-v-c:block,i-ci:ver25,r-cr:hor20,t:ver25"

-- variables
vim.diagnostic.config({
    virtual_text = false,
    signs = false,
    underline = false,
    update_in_insert = false,
})

-- keybinds
vim.cmd("tnoremap <C-q> <C-\\><C-n>")
map("n", "<C-f>", function()
    vim.lsp.buf.format({ async = false })
    vim.lsp.buf.code_action({
        context = { only = { "source.fixAll" } },
        apply = true,
    })
end, { silent = true })
map("n", "<C-s>", ":noa wa<CR>", { silent = true })
map("n", "<C-b>", ":make <CR>", { silent = true })
map("n", "<C-s-b>", ":make run<CR>", { silent = true })
map("v", "<C-y>", '"+y', { silent = true })
map("n", "<C-p>", '"+p', { silent = true })
map("v", "<C-p>", '"_dP', { silent = true })
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-x>", ":vsplit<CR>")
map("n", "<leader>swap", "<C-w><C-x>")
map("n", "J", ":bprevious<CR>")
map("n", "K", ":bnext<CR>")
map("n", "H", ":tabprev<CR>")
map("n", "L", ":tabnext<CR>")
map("n", "<C-t>", ":term<CR>")
map("n", "<A-n>", ":cnext<CR>")
map("n", "<A-p>", ":cprev<CR>")
map("n", "gz", ":!zeal \"<cword>\"&<CR><CR>")
-- Commands

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
    vim.cmd('copen')
end, { nargs = 1 })

vim.api.nvim_create_user_command("Mdone", function()
    require("user.commands").toggleStrikeThrough()
end, {})

vim.api.nvim_create_user_command("Mtmp", function()
    require("user.commands").mktemp()
end, {})
vim.api.nvim_create_user_command("Mput", function(opts)
    require("user.commands").echoOutput(opts)
end, { nargs = "+" })
vim.api.nvim_create_user_command("Mview", function(opts)
    require("user.commands").viewOutput(opts)
end, { nargs = "+" })

vim.api.nvim_create_user_command("Mviews", function(opts)
    vim.fn.execute("vsplit")
    require("user.commands").viewOutput(opts)
end, { nargs = "+" })

-- autocmds
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        local opts = { buffer = ev.buf }
        map("n", "gd", vim.lsp.buf.definition, opts)
        map("n", "gr", vim.lsp.buf.references, opts)
        map("n", "gh", vim.lsp.buf.hover, opts)
        map("n", "<leader>ih", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, opts)

        -- should fix slow saves, I hope
        vim.api.nvim_clear_autocmds({
            group = "nvim.lsp.b_" .. ev.buf .. "_save",
        })
    end,
})

vim.api.nvim_create_autocmd("CursorMoved", {
    group = vim.api.nvim_create_augroup("auto-hlsearch", { clear = true }),
    callback = function()
        if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
            vim.schedule(function()
                vim.cmd.nohlsearch()
            end)
        end
    end,
})

vim.api.nvim_create_autocmd('TermOpen', {
    command = 'setlocal signcolumn=auto',
})

local ns = vim.api.nvim_create_namespace('my.terminal.prompt')
vim.api.nvim_create_autocmd('TermRequest', {
    callback = function(args)
        if string.match(args.data.sequence, '^\027]133;A') then
            local lnum = args.data.cursor[1]
            vim.api.nvim_buf_set_extmark(args.buf, ns, lnum - 1, 0, {
                sign_text = '▶',
                sign_hl_group = 'SpecialChar',
            })
        end
    end,
})

vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("custom-term-settings", { clear = true }),
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
    end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

if capabilities.workspace then
    capabilities.workspace.didChangeWatchedFiles = nil
end

capabilities.textDocument.semanticTokens.multilineTokenSupport = true

vim.lsp.config('*', {
    root_markers = { '.git', { 'build.zig' } },
    capabilities = capabilities,
})

-- lsp
vim.lsp.enable({
    "zls",
    "clangd",
    "lua_ls",
})

-- plugins
vim.pack.add({
    "https://github.com/stevearc/oil.nvim",
    --"https://github.com/3rd/image.nvim",
    "https://github.com/kylechui/nvim-surround",
    "https://github.com/rmagatti/auto-session",
    "https://github.com/mfussenegger/nvim-dap",
    "https://github.com/igorlfs/nvim-dap-view",
})

require("auto-session").setup({
    auto_save_enabled = true,
    auto_restore_enabled = true,
    auto_session_suppress_dirs = { "/", "~/", "~/Downloads", "~/Archives" },
})

-- require("image").setup({
--     backend = "sixel",
--     processor = "magick_cli",
-- })
require("oil").setup({
    default_file_explorer = true,
    use_default_keymaps = false,
    view_options = {
        show_hidden = false,
    },

    keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<C-e>"] = { "actions.close", mode = "n" },                 -- toggle
        ["<CR>"] = { "actions.select", opts = { vertical = true } }, -- open in new window
        ["<Tab>"] = { "actions.preview", mode = "n" },               -- preview
        ["R"] = { "actions.refresh", mode = "n" },
        ["."] = "actions.select",                                    -- go into
        ["-"] = { "actions.parent", mode = "n" },                    -- go out of
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
    },
})
vim.keymap.set("n", "<C-e>", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- set_hl(0, "BlinkCmpSignatureHelp", { link = "BlinkCmpMenu" })
-- set_hl(0, "BlinkCmpSignatureHelpBorder", { link = "BlinkCmpMenuBorder" })
-- set_hl(0, "BlinkCmpSignatureHelpActiveParameter", { link = "LspSignatureActiveParameter" })

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
vim.api.nvim_create_autocmd({ 'CmdlineChanged', 'CmdlineLeave' }, {
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

vim.keymap.set('c', '<c-v>', '<home><s-right><c-w>vs<end>', { desc = 'Change command to :vs' })
vim.keymap.set('c', '<c-s>', '<home><s-right><c-w>sp<end>', { desc = 'Change command to :sp' })


vim.cmd("colorscheme silentium")
--vim.cmd("colorscheme retrobox")
