return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local map = vim.keymap.set
		local builtin = require("telescope.builtin")
		local action_state = require("telescope.actions.state")
		local actions = require("telescope.actions")

		buffer_searcher = function()
			builtin.buffers({
				sort_mru = true,
				ignore_current_buffer = true,
				initial_mode = "insert",
				attach_mappings = function(prompt_bufnr, map_b)
					local refresh_buffer_searcher = function()
						actions.close(prompt_bufnr)
						vim.schedule(buffer_searcher)
					end

					local delete_buf = function()
						local selection = action_state.get_selected_entry()
						vim.api.nvim_buf_delete(selection.bufnr, { force = true })
						refresh_buffer_searcher()
					end

					local delete_multiple_buf = function()
						local picker = action_state.get_current_picker(prompt_bufnr)
						local selection = picker:get_multi_selection()
						for _, entry in ipairs(selection) do
							vim.api.nvim_buf_delete(entry.bufnr, { force = true })
						end
						refresh_buffer_searcher()
					end

					map_b("n", "dd", delete_buf)
					map_b("n", "<C-d>", delete_multiple_buf)
					map_b("i", "<C-d>", delete_multiple_buf)
					return true
				end,
			})
		end

		map("n", "<leader>fs", builtin.find_files, { desc = "File Search" })
		map("n", "<leader>es", builtin.diagnostics, { desc = "Error Search" })
		map("n", "<leader>ps", builtin.live_grep, { desc = "Pattern Search (Ag)" })
		map("n", "<leader>bs", buffer_searcher, { desc = "Buffer search" })
	end,
}
