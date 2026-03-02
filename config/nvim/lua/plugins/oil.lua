return {
	"stevearc/oil.nvim",
	dependencies = { { "nvim-mini/mini.icons", opts = {} } },
	lazy = false,
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			use_default_keymaps = false,
			view_options = {
				show_hidden = false,
			},

			keymaps = {
				["g?"] = { "actions.show_help", mode = "n" },
				["<C-e>"] = { "actions.close", mode = "n" }, -- toggle
				["<CR>"] = { "actions.select", opts = { vertical = true } }, -- open in new window
				["<Tab>"] = { "actions.preview", mode = "n" }, -- preview
				-- ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
				-- ["<C-t>"] = { "actions.select", opts = { tab = true } },
				["R"] = { "actions.refresh", mode = "n" },
				["."] = "actions.select", -- go into
				["-"] = { "actions.parent", mode = "n" }, -- go out of
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
	end,
}
