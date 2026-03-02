return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters = {
				["clang-format"] = {
					prepend_args = {
						"-style={BasedOnStyle: LLVM, ColumnLimit: 120, AllowShortIfStatementsOnASingleLine: true, IndentWidth: 4, TabWidth: 8}",
					},
				},
			},

			formatters_by_ft = {
				zig = { "zigfmt" },
				c = { "clang-format" },
				lua = { "stylua" },
				cpp = { "clang-format" },
				json = { "prettierd" },
			},
			format_on_save = {
                                enabled = false, 
			},
		})
	end,
}
