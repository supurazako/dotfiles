vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "en", "cjk" }
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})

