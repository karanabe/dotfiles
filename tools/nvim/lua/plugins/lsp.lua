local diagnostics = vim.g.lazyvim_rust_diagnostics or "rust-analyzer"

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bacon_ls = {
          enabled = diagnostics == "bacon-ls",
        },
        rust_analyzer = {},
      },
    },
  },
}
