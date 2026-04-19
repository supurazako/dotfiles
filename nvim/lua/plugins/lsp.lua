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
	  	},
	  	config = function()
			require("mason").setup()
  
			local capabilities = require("blink.cmp").get_lsp_capabilities()
  
			local on_attach = function(_, bufnr)
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
			end
  
			vim.lsp.config("clangd", {
			capabilities = capabilities,
			on_attach = on_attach,
			})
  
			vim.lsp.config("gopls", {
			capabilities = capabilities,
			on_attach = on_attach,
			})
  
			vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			on_attach = on_attach,
			})
  
			vim.lsp.enable("clangd")
			vim.lsp.enable("gopls")
			vim.lsp.enable("lua_ls")
	  	end,
	},
}
