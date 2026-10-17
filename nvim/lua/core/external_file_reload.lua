-- Reload files changed by external tools, such as coding agents.
vim.o.autoread = true

-- Neovim 0.13 adds native filesystem watching for 'autoread'.
if vim.fn.has("nvim-0.13") == 1 then
  return
end

local uv = vim.uv or vim.loop
local group = vim.api.nvim_create_augroup("external_file_autoread", { clear = true })
local watched_dirs = {}
local buffer_dirs = {}

local function detach(bufnr)
  local dir = buffer_dirs[bufnr]
  if not dir then
    return
  end

  buffer_dirs[bufnr] = nil
  local entry = watched_dirs[dir]
  if not entry then
    return
  end

  entry.buffers[bufnr] = nil
  if next(entry.buffers) == nil then
    entry.watcher:stop()
    entry.watcher:close()
    watched_dirs[dir] = nil
  end
end

local function attach(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].buftype ~= "" then
    return
  end

  local name = vim.api.nvim_buf_get_name(bufnr)
  if name == "" or name:match("^%a[%w+.-]*://") then
    detach(bufnr)
    return
  end

  local path = vim.fn.fnamemodify(name, ":p")
  local dir = vim.fn.fnamemodify(path, ":h")
  local filename = vim.fn.fnamemodify(path, ":t")

  if buffer_dirs[bufnr] == dir then
    local entry = watched_dirs[dir]
    if entry then
      entry.buffers[bufnr] = filename
      return
    end
  end

  detach(bufnr)
  local entry = watched_dirs[dir]
  if not entry then
    local watcher = uv.new_fs_event()
    if not watcher then
      return
    end
    entry = { watcher = watcher, buffers = {} }
    watched_dirs[dir] = entry

    local started = watcher:start(dir, {}, function(err, changed)
      if err then
        return
      end

      local changed_name = changed and vim.fn.fnamemodify(changed, ":t")
      vim.schedule(function()
        for watched_buf, watched_name in pairs(entry.buffers) do
          if changed_name == nil or changed_name == watched_name then
            if vim.api.nvim_buf_is_valid(watched_buf) then
              pcall(vim.api.nvim_buf_call, watched_buf, function()
                vim.cmd("checktime")
              end)
            end
          end
        end
      end)
    end)

    if not started then
      watched_dirs[dir] = nil
      watcher:close()
      return
    end
  end

  entry.buffers[bufnr] = filename
  buffer_dirs[bufnr] = dir
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "BufWritePost", "BufFilePost", "BufEnter" }, {
  group = group,
  callback = function(args)
    attach(args.buf)
  end,
})

vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
  group = group,
  callback = function(args)
    detach(args.buf)
  end,
})
