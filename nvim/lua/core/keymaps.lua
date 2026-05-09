local keymap = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- jj
keymap("i", "jj", "<Esc>", {
    desc = "Exit insert mode",
})
