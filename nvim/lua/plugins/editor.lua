return {
  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
            ["<C-q>"] = "send_selected_to_qflist",
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
    },
  },

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
