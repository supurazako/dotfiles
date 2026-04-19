return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "lua",
                    "vim",
                    "vimdoc",
                    "c",
                    "go",
                    "javascript",
                    "typescript",
                },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
}
