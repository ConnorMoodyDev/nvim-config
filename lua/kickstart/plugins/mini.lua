return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      local pairs = require 'mini.pairs'

      pairs.setup()

      local basics = require 'mini.basics'
      basics.setup {
        mappings = {
          basic = true,
          windows = true,
        },
      }

      local move = require 'mini.move'
      move.setup()

      -- require('mini.extra').setup()
      -- local ai = require 'mini.ai'
      -- local spec_treesitter = require('mini.ai').gen_spec.treesitter
      -- ai.setup {
      --   n_lines = 5000,
      --   custom_textobjects = {
      --     B = MiniExtra.gen_ai_spec.buffer(),
      --     I = MiniExtra.gen_ai_spec.indent(),
      --     L = MiniExtra.gen_ai_spec.line(),
      --     T = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' },
      --   },
      -- }
      --
      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
