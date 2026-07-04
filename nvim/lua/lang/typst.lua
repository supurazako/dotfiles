vim.api.nvim_create_autocmd("FileType", {
  pattern = "typst",
  callback = function(event)
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "en", "cjk" }
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true

    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = event.buf, desc = desc })
    end

    map("<leader>tp", "<cmd>TypstPreviewToggle<cr>", "Typst preview toggle")
    map("<leader>tf", "<cmd>TypstPreviewFollowCursorToggle<cr>", "Typst preview follow cursor")
    map("<leader>ts", "<cmd>TypstPreviewSyncCursor<cr>", "Typst preview sync cursor")
  end,
})
