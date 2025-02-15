return {
  {
    'wurli/split.nvim',
    opts = {
      keymaps = {
        -- `gSS` will split the whole line without operator-pending mode
        ['gs'] = {
          desc = 'Split the line by ->',
          pattern = '->%s*',
          operator_pending = false,
          interactive = false,
          break_placement = 'before_pattern',
          post_split = function(lines)
            -- Remove any extra spaces after `->` in the new line
            for i, line in ipairs(lines) do
              lines[i] = line:gsub('^%s*->%s*', '->') -- Trim spaces before method names
            end
          end,
        },
      },
      interactive_options = {
        -- Allows custom behavior in interactive mode (`gS` mode)
        ['->'] = {
          pattern = '->%s*',
          break_placement = 'before_pattern', -- Places `->` at the start of the new line
          post_split = function(lines)
            -- Remove any extra spaces after `->` in the new line
            for i, line in ipairs(lines) do
              lines[i] = line:gsub('^%s*->%s*', '->') -- Trim spaces before method names
            end
          end,
        },
      },
      keymap_defaults = {
        break_placement = function(line_info, opts)
          if line_info.filetype == 'php' and not line_info.comment then
            return 'before_pattern' -- Keeps method chains readable
          end
          return 'after_pattern'
        end,
        indenter = function(line_info)
          if line_info.filetype == 'php' then
            return '    ' -- Use 4 spaces for indentation
          end
          return nil
        end,
        trim_spaces = true, -- ✅ Remove extra spaces when splitting
      },
    },
  },
}
