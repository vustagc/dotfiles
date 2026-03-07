local M = {}

local function get_filetype(cmd)
    local first = cmd:match("^(%S+)")
    if not first then return "" end

    local mapping = {
        man = "man",
        sh = "sh",
    }

    return mapping[first] or ""
end

local function run_fn_or_vim(cmd)
    local args = vim.split(cmd, "%s+", { trimempty = true })

    local output
    if args[1] == "vim" and #args > 1 then
        local vim_cmd = table.concat(vim.list_slice(args, 2, #args), " ")
        output = vim.fn.execute(vim_cmd)
    else
        output = vim.fn.system(cmd)
    end

    return vim.split(output, "\n", { trimempty = true })
end


M.mktemp = function()
    local tmp = vim.api.nvim_create_buf(true, true)
    vim.cmd.buffer(tmp)
    vim.bo[tmp].buftype = "nofile"
    vim.api.nvim_buf_set_name(tmp, "M:" .. os.time())

    return tmp
end

M.echoOutput = function(opts)
    local lines = run_fn_or_vim(opts.args)
    vim.api.nvim_put(lines, "l", true, true)
end

M.viewOutput = function(opts)
    local name = "M:" .. opts.args

    local buf = vim.fn.bufnr(name)
    if buf == -1 or not vim.api.nvim_buf_is_valid(buf) then
        buf = vim.api.nvim_create_buf(true, true)
        vim.api.nvim_buf_set_name(buf, name)
        vim.bo[buf].buftype = "nofile"
    end
    vim.api.nvim_set_current_buf(buf)

    local lines = run_fn_or_vim(opts.args)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].filetype = get_filetype(opts.args)
end

-- github.com/justamanpop/strike-through.nvim
function M.toggleStrikeThrough()
	local curr_line = vim.api.nvim_get_current_line()
	local strike_through_char = "\xCC\xB6"
	local is_struck_through = string.find(curr_line, strike_through_char) ~= nil

	if is_struck_through then
		local no_strike_through_line = string.gsub(curr_line, strike_through_char, "")
		vim.api.nvim_set_current_line(no_strike_through_line)
	else
		vim.cmd("s/./&̶/g")
		vim.cmd("nohl")
	end
end

return M
