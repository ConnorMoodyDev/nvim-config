return {
  {
    'nanozuki/tabby.nvim',
    -- event = 'VimEnter', -- if you want lazy load, see below
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      local theme = {
        fill = { fg = '#f2e9de', bg = '#907aa9', style = 'italic' },
        head = 'TabLine',
        current_tab = 'TabLineSel',
        tab = 'TabLine',
        win = 'TabLine',
        tail = 'TabLine',
      }
      require('tabby').setup {
        line = function(line)
          return {
            {
              { '  ', hl = theme.head },
              line.sep('', theme.head, theme.fill),
            },
            line.tabs().foreach(function(tab)
              local hl = tab.is_current() and theme.current_tab or theme.tab
              return {
                line.sep('', hl, theme.fill),
                tab.is_current() and '' or '󰆣',
                tab.number(),
                tab.name(),
                tab.close_btn '',
                line.sep('', hl, theme.fill),
                hl = hl,
                margin = ' ',
              }
            end),
            line.spacer(),
            line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
              return {
                line.sep('', theme.win, theme.fill),
                win.is_current() and '' or '',
                win.buf_name(),
                line.sep('', theme.win, theme.fill),
                hl = theme.win,
                margin = ' ',
              }
            end),
            {
              line.sep('', theme.tail, theme.fill),
              { '  ', hl = theme.tail },
            },
            hl = theme.fill,
          }
        end,
        -- option = {}, -- setup modules' option,
      }
      -- configs...
      vim.api.nvim_set_keymap('n', '<leader>ta', ':$tabnew<CR>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>tc', ':tabclose<CR>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>to', ':tabonly<CR>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>tn', ':tabn<CR>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>tp', ':tabp<CR>', { noremap = true })

      vim.keymap.set('n', '<leader>tr', function()
        vim.ui.input({ prompt = 'Rename tab to: ' }, function(input)
          if not input or input == '' then
            print 'No tab name entered.'
            return
          end
          vim.api.nvim_command('Tabby rename_tab ' .. input)
        end)
      end, { noremap = true })
      -- move current tab to previous position
      vim.api.nvim_set_keymap('n', '<leader>tmp', ':-tabmove<CR>', { noremap = true })
      -- move current tab to next position
      vim.api.nvim_set_keymap('n', '<leader>tmn', ':+tabmove<CR>', { noremap = true })
    end,
  },
}
