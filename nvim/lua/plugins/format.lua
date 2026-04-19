return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    opts = {
      notify_on_error = true,
      format_on_save = function(bufnr)
        return {
          timeout_ms = 800,
          lsp_format = "fallback",
        }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "gofmt" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
      },
    },
  },
}
