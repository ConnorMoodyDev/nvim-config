return {
  {
    'StephenGunn/sveltecheck.nvim',
    config = function()
      require('sveltecheck').setup {
        command = 'bun run check', -- Default command for pnpm
      }
    end,
  },
}
