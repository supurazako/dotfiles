return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "saghen/blink.cmp",
      "SmiteshP/nvim-navic",
    },
    config = function()
      require("mason").setup()

      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local navic = require("nvim-navic")

      local tinymist_cmd = function()
        if vim.fn.executable("tinymist") == 1 then
          return { "tinymist" }
        end

        local bins = vim.fn.glob(vim.fn.stdpath("data") .. "/typst-preview/tinymist*", false, true)
        for _, bin in ipairs(bins) do
          if vim.fn.executable(bin) == 1 then
            return { bin }
          end
        end

        return { "tinymist" }
      end

      local on_attach = function(client, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "gr", vim.lsp.buf.references, "References")
        map("n", "K", vim.lsp.buf.hover, "Hover")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
        map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")

        if client.server_capabilities.documentSymbolProvider then
          navic.attach(client, bufnr)
        end
      end

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      vim.lsp.config("gopls", {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- TypeScript 7 ships its own native LSP.  Use it directly instead of
      -- typescript-language-server, which depends on the removed tsserver.js.
      vim.lsp.config("ts_native", vim.tbl_deep_extend("force", vim.lsp.config.tsgo, {
        cmd = { "tsc", "--lsp", "--stdio" },
        capabilities = capabilities,
        on_attach = on_attach,
      }))

      vim.lsp.config("clangd", {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      vim.lsp.config("tinymist", {
        capabilities = capabilities,
        cmd = tinymist_cmd(),
        on_attach = on_attach,
      })

      vim.lsp.enable("lua_ls")
      vim.lsp.enable("gopls")
      vim.lsp.enable("ts_native")
      vim.lsp.enable("clangd")
      vim.lsp.enable("tinymist")
    end,
  },
}
