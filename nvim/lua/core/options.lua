-- line number
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"

-- indent
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = false
  end,
})

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- UI
vim.opt.termguicolors = true
vim.opt.mouse = "a"

-- scroll
vim.opt.scrolloff = 8

-- clipboard
vim.opt.clipboard = "unnamedplus"

-- swap/backup
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

-- update time
vim.opt.updatetime = 250

-- for jj
vim.opt.timeoutlen = 300

vim.opt.list = true
vim.opt.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "␣",
}
