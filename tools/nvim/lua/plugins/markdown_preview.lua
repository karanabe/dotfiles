return {
  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    keys = {
      { "<leader><space>mt", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview Toggle", mode = "n" },
      { "<leader><space>mc", "<cmd>MarkdownPreview<cr>", desc = "Markdown Preview Create", mode = "n" },
      { "<leader><space>mx", "<cmd>MarkdownPreviewStop<cr>", desc = "Markdown Preview Stop", mode = "n" },
    },
    build = "cd app && yarn install",
  },
}
