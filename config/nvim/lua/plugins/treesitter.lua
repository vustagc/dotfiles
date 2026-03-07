return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		-- require("nvim-treesitter").setup({})
		-- require("nvim-treesitter").install({ "zig", "c", "python", "javascript", "json" })
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"zig",
				"c",
				"cpp",
				"lua",
				"python",
				"javascript",
				"json",
			},
			highlight = { enable = true },
		})
	end,
}
