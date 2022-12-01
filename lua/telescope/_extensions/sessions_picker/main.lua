P = function(v)
    print(vim.inspect(v))
    return vim
end

local has_telescope, telescope = pcall(require, 'telescope')

local M = {}

if not has_telescope then
  error('This plugins requires nvim-telescope/telescope.nvim')
end

local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local actions_state = require("telescope.actions.state")
local conf = require("telescope.config").values

-- Switch Tmux session given the session name
local switch_session = function(prompt_bufnr, map)
    local dir = actions_state.get_selected_entry(prompt_bufnr).value
    local first
    for token in string.gmatch(dir, "[^%s]+") do
        first = token
        break
    end
    first = first:sub(1, -2)
    os.execute("tmux switch -t " .. first)
end

-- Execute tmux ls and returns formatted lines
local get_tmux_sessions = function()
    local n = os.tmpname()
    os.execute("tmux ls > " .. n)
    local formattedLines = {}
    local i = 0
    for line in io.lines (n) do
        formattedLines[i] = line
        i = i+1
    end
    return formattedLines
end

-- our picker function: colors
local sessions_picker = function(opts)
    local formattedLines = get_tmux_sessions()

    opts = opts or {}
    pickers.new(opts, {
    prompt_title = "Select a tmux session",
    results_title = "Tmux Sessions",
    finder = finders.new_table {
      results = formattedLines
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
        map('i', '<CR>', switch_session)
        map('n', '<CR>', switch_session)
        return true
    end
  }):find()
end

M.setup = function()
end

M.run_sessions_picker = function(opts)
    opts = opts or {}

    sessions_picker(opts)
end

return M

