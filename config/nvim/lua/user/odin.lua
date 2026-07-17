local M = {}

local function make_absolute(filename, cwd)
        if not filename or filename == "" then
                return filename
        end

        if filename:match("^%a:[/\\]") or vim.startswith(filename, "/") then
                return filename
        end

        return vim.fs.normalize(vim.fs.joinpath(cwd, filename))
end

function M.build()
        local cwd = vim.fn.getcwd()

        vim.system({ "odin", "build", ".", "-debug" }, { cwd = cwd, text = true }, function(result)
                vim.schedule(function()
                        -- handle result
                        local output = vim.trim(table.concat({ result.stdout or "", result.stderr or "" }, "\n"))
                        local lines = vim.split(output, "\n", { plain = true })
                        if lines[#lines] == "" then
                                table.remove(lines)
                        end

                        local errorformat = table.concat({
                                "%f(%l:%c) %t%*[^:]: %m",
                                "%f(%l) %t%*[^:]: %m",
                                "%-G%.%#",
                        }, ",")

                        local previous_cwd = vim.fn.getcwd()
                        if cwd and cwd ~= "" then
                                vim.fn.chdir(cwd)
                        end
                        local ok, res = pcall(vim.fn.getqflist, { lines = lines, efm = errorformat })
                        vim.fn.chdir(previous_cwd)

                        if not ok then
                                error(res)
                        end
                        local parsed = res.items

                        local items = {}
                        for _, item in ipairs(parsed) do
                                if item.valid == 1 then
                                        if item.filename and item.filename ~= "" then
                                                vim.notify("yes", vim.log.levels.ERROR, { title = "odin build" })
                                                item.filename = make_absolute(item.filename, previous_cwd)
                                        end

                                        table.insert(items, item)
                                end
                        end

                        vim.fn.setqflist({}, 'r', {
                                title = 'Odin ',
                                items = items
                        })

                        if result.code ~= 0 and #items > 0 then
                                vim.cmd('copen')
                                vim.notify("Errors", vim.log.levels.ERROR, { title = "odin build" })
                        else
                                vim.notify("Built", vim.log.levels.INFO, { title = "odin build" })
                        end

                        --
                end)
        end)
end

return M
