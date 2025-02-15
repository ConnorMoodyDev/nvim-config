return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      terminal = { enabled = true },
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      scroll = { enabled = true },
      picker = {
        enabled = true,
      },
    },
    keys = {
      {
        '<leader>sf',
        function()
          Snacks.picker.files()
        end,
        desc = '[S]earch [F]iles',
      },
      {
        '<leader>ss',
        function()
          vim.ui.input({ prompt = 'Enter file type (e.g., lua, svelte, js): ' }, function(filetype)
            if not filetype or filetype == '' then
              print 'No file type entered.'
              return
            end

            -- Execute snacks.picker.grep with the given file type
            Snacks.picker.grep {
              ft = filetype,
            }
          end)
        end,
      },
      {
        '<leader>sg',
        function()
          Snacks.picker.grep {
            cmd = 'rg',
          }
        end,
        desc = '[S]earch [G]rep',
      },
      {
        '<leader>gd',
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = '[G]oto [D]efinition',
      },
      {
        'gd',
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = 'Goto Definition',
      },
      {
        'gy',
        function()
          Snacks.picker.lsp_type_definitions()
        end,
        desc = 'Goto T[y]pe Definition',
      },
      {
        'gI',
        function()
          Snacks.picker.lsp_implementations()
        end,
        desc = 'Goto Implementation',
      },
      {
        'gr',
        function()
          Snacks.picker.lsp_references()
        end,
        nowait = true,
        desc = 'References',
      },
      {
        '<leader>fr',
        function()
          Snacks.picker.recent()
        end,
        desc = 'Recent',
      },
      {
        '<leader>sm',
        function()
          Snacks.picker.marks()
        end,
        desc = 'Marks',
      },
    },
  },
}
