return {
  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    version = "1.*",
    opts = function()
      local dependencies_bin = {}

      if vim.fn.executable("tinymist") == 1 then
        dependencies_bin.tinymist = "tinymist"
      end

      return {
        dependencies_bin = dependencies_bin,
      }
    end,
  },
}
