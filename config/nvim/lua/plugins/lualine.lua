return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = { theme = "gruvbox" },
			tabline = {
				lualine_a = { "tabs" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
				-- lualine_z = { "buffers" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "searchcount", { "filename", path = 1 } },
				lualine_c = {},
				lualine_x = {"encoding"},
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
