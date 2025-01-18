-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = true,
      columns = {
        'icon',
      },

      view_options = {
        show_hidden = true,
      },
    },
    init = function()
      require 'oil'
    end,
    keys = {
      { '-', '<CMD>Oil<CR>', desc = 'Open parent directory' },
    },
    -- Optional dependencies
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },
  {
    'tpope/vim-sleuth', -- detect tabstop and shiftwidth
  },
}
