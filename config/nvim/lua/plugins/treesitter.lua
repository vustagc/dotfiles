return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"zig",
				"c",
				"cpp",
				"lua",
				"python",
				"javascript",
				"json",
                                "markdown",
                                "markdown_inline",
			},
			highlight = { enable = true },
		})
	end,
}
