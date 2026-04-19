return {
  -- indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      indent = { char = "▏" },
      scope = { enabled = true },
      exclude = {
        filetypes = {
          "help",
          "lazy",
          "mason",
          "NvimTree",
          "Trouble",
          "terminal",
          "dashboard",
        },
      },
    },
  },

  -- trailing whitespace
  {
    "echasnovski/mini.trailspace",
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mini.trailspace").setup()

      vim.keymap.set("n", "<leader>uw", function()
        MiniTrailspace.trim()
      end, { desc = "Trim trailing whitespace" })
    end,
  },
}

