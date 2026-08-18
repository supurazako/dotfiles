local function prefer_volta_tree_sitter()
    local bin_dir = vim.fn.expand("~/.volta/tools/image/packages/tree-sitter-cli/bin")
    local tree_sitter = bin_dir .. "/tree-sitter"

    if vim.uv.fs_stat(tree_sitter) then
        vim.env.PATH = bin_dir .. ":" .. vim.env.PATH
    end
end

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = function()
            prefer_volta_tree_sitter()
            require("nvim-treesitter").update():wait(300000)
        end,
        config = function()
            local parsers = {
                "lua",
                "vim",
                "vimdoc",
                "c",
                "go",
                "javascript",
                "typescript",
            }

            prefer_volta_tree_sitter()

            local treesitter = require("nvim-treesitter")
            treesitter.setup()

            if treesitter.install and vim.fn.executable("tree-sitter") == 1 and vim.fn.executable("cc") == 1 then
                treesitter.install(parsers)
            end

            vim.api.nvim_create_autocmd("FileType", {
                pattern = parsers,
                callback = function()
                    if not pcall(vim.treesitter.start) then
                        return
                    end

                    if treesitter.indentexpr then
                        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })
        end,
    },
}
