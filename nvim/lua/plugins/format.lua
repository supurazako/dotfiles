return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    opts = {
      notify_on_error = true,
      format_on_save = function(bufnr)
        local filetype = vim.bo[bufnr].filetype
        if filetype == "c" or filetype == "cpp" then
          if vim.fn.executable("clang-format") == 0 then
            vim.notify("clang-format is not installed or not found in PATH", vim.log.levels.ERROR)
            return nil
          end

          return {
            timeout_ms = 800,
            lsp_format = "never",
          }
        end

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
        typst = { "typstyle" },
        c = { "clang-format" },
        cpp = { "clang-format" },
      },
      formatters = {
        ["clang-format"] = {
          prepend_args = function(_, ctx)
            local config = vim.fs.find({ ".clang-format", "_clang-format" }, {
              path = ctx.dirname,
              upward = true,
            })
            if #config > 0 then
              return {}
            end

            return {
              "--style={BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4, UseTab: Always}",
            }
          end,
        },
      },
    },
  },
}
