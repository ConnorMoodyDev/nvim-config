vim.api.nvim_create_user_command('MigrateToSvelte5', function()
  -- Get the current buffer's file type
  local filetype = vim.bo.filetype
  if filetype ~= 'svelte' then
    vim.notify('This command can only be run on Svelte files.', vim.log.levels.ERROR)
    return
  end

  -- Get the URI of the current buffer
  local uri = vim.uri_from_bufnr(0)

  -- Find the Svelte LSP client
  local svelte_client = nil
  for _, client in pairs(vim.lsp.get_active_clients()) do
    if client.name == 'svelte' then
      svelte_client = client
      break
    end
  end

  if not svelte_client then
    vim.notify('Svelte LSP is not running.', vim.log.levels.ERROR)
    return
  end

  -- Spinner state
  local spinner_frames = { '   ⠋', '   ⠙', '   ⠚', '   ⠞', '   ⠖', '   ⠦', '   ⠴', '   ⠲', '   ⠳', '   ⠓' }

  local spinner_index = 1
  local spinner_timer = vim.loop.new_timer()
  vim.cmd 'highlight SpinnerColor guifg=#89B4FA'

  local function create_floating_spinner()
    local buf = vim.api.nvim_create_buf(false, true) -- Create a scratch buffer
    local width = 60
    local height = 3
    local opts = {
      relative = 'editor',
      width = width,
      height = height,
      col = (vim.o.columns - width) / 2,
      row = (vim.o.lines - height) / 2,
      style = 'minimal',
      border = 'rounded',
    }
    local win = vim.api.nvim_open_win(buf, false, opts)
    return buf, win
  end

  local buf, win = create_floating_spinner()

  -- Start the spinner
  spinner_timer:start(
    0,
    100,
    vim.schedule_wrap(function()
      local spinner_message = spinner_frames[spinner_index]
      -- Update the content of the floating window
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
        '',
        '   ' .. spinner_message .. ' Migrating component to Svelte 5...',
        '',
      })
      vim.api.nvim_buf_add_highlight(buf, -1, 'SpinnerColor', 1, 3, 4) -- Highlight the spinner
      spinner_index = (spinner_index % #spinner_frames) + 1
    end)
  )

  local function stop_spinner()
    spinner_timer:stop()
    spinner_timer:close()
    vim.api.nvim_win_close(win, true)
    vim.notify('✔ Migration complete!', vim.log.levels.INFO)
  end

  -- Send the migrate_to_svelte_5 command
  svelte_client.request('workspace/executeCommand', {
    command = 'migrate_to_svelte_5',
    arguments = { uri },
  }, function(err, result)
    -- Handle errors
    if err then
      spinner_timer:stop()
      spinner_timer:close()
      vim.api.nvim_win_close(win, true)
      vim.notify('✘ Migration failed: ' .. err.message, vim.log.levels.ERROR)
      return
    end

    -- Stop the spinner
    stop_spinner()
    -- Notify success
  end)
end, {
  desc = 'Migrate the current Svelte file to Svelte 5',
  nargs = 0,
})

vim.keymap.set('n', '<leader>ms', '<cmd>MigrateToSvelte5<CR>', { desc = 'Migrate to Svelte 5' })
