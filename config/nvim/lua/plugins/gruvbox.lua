return {
	"ellisonleao/gruvbox.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("gruvbox").setup({
			contrast = "hard",
			transparent_mode = true,
			bold = false,
			italic = {
				strings = false,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
			},
			overrides = {
				DiagnosticUnnecessary = { link = "Comment" },
			},
		})
	end,
}
