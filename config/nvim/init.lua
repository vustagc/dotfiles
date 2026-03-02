local opt = vim.opt
local map = vim.keymap.set
local set_hl = vim.api.nvim_set_hl

-- variables
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.zig_fmt_parse_errors = 0
vim.g.zig_fmt_autosave = 0

-- options
opt.encoding = "utf-8"
opt.background = "dark"
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.showtabline = 2
opt.cursorline = true
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
opt.laststatus = 3
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

vim.diagnostic.config({
	virtual_text = false,
	signs = false,
	underline = false,
	update_in_insert = false,
})

-- keybinds
vim.cmd("tnoremap <C-q> <C-\\><C-n>")
map("n", "<C-s>", ":noa w<CR>", { silent = true })
map("n", "<C-b>", ":make <CR>", { silent = true })
map("n", "<C-s-b>", ":make run<CR>", { silent = true })

map("v", "<C-y>", '"+y', { silent = true })
map("n", "<C-p>", '"+p', { silent = true })
map("n", "<C-h>", "<C-w>h", { desc = "Window Left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window Down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window Up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window Right" })
map("n", "J", ":bprevious<CR>", { desc = "Prev Buffer" })
map("n", "K", ":bnext<CR>", { desc = "Next Buffer" })
map("n", "H", ":tabprev<CR>", { desc = "Prev Tab" })
map("n", "L", ":tabnext<CR>", { desc = "Next Tab" })
map("n", "<C-t>", ":tabe<CR>", { desc = "New Tab" })
map("n", "<A-n>", ":cnext<CR>", { desc = "Quickfix Next" })
map("n", "<A-p>", ":cprev<CR>", { desc = "Quickfix Previous" })
map("n", "<leader>open", ":AutoSession search<CR>")

-- autocmds
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		map("n", "gd", vim.lsp.buf.definition, opts)
		map("n", "gy", vim.lsp.buf.type_definition, opts)
		map("n", "gi", vim.lsp.buf.implementation, opts)
		map("n", "gr", vim.lsp.buf.references, opts)
		map("n", "<leader>g", vim.diagnostic.goto_next, opts)
		map("n", "<leader>G", vim.diagnostic.goto_prev, opts)
		map("n", "gh", vim.lsp.buf.hover, opts)
		map("n", "<leader>ih", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, opts)
		map("n", "<F9>", vim.lsp.buf.code_action, opts)
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

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-settings", { clear = true }),
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
	end,
})

-- startup
require("config.lazy")
require("lazy").setup("plugins")
-- vim.lsp.enable({ "zls", "clangd", "lua_ls" })

vim.cmd("colorscheme gruvbox")

set_hl(0, "BlinkCmpSignatureHelp", { link = "BlinkCmpMenu" })
set_hl(0, "BlinkCmpSignatureHelpBorder", { link = "BlinkCmpMenuBorder" })
set_hl(0, "BlinkCmpSignatureHelpActiveParameter", { link = "LspSignatureActiveParameter" })
