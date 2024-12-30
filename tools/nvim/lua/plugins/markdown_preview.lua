return {
  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    keys = {
      { mode = "n", "<leader><space>mt", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Markdonw Preview Toggle" } },
      { mode = "n", "<leader><space>mc", "<cmd>MarkdownPreview<cr>", { desc = "Markdown Preview Create" } },
      { mode = "n", "<leader><space>mx", "<cmd>MarkdownPreviewStop<cr>", { desc = "Markdown Preview Stop" } },
    },
    build = function() vim.fn["mkdp#util#install"]() end,
  }
}
