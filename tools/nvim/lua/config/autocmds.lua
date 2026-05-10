-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
  group = augroup("setLineLength", { clear = true }),
  pattern = { "text", "markdown" },
  callback = function()
    vim.opt_local.colorcolumn = "0"
  end,
})

autocmd("FileType", {
  group = augroup("setIndent2", { clear = true }),
  pattern = {
    "xml",
    "html",
    "xhtml",
    "css",
    "scss",
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
    "yaml",
    "lua",
    "java",
    "c",
    "cpp",
    "ruby",
    "bash",
  },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})

autocmd("FileType", {
  group = augroup("setIndent4", { clear = true }),
  pattern = { "python", "rust" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})

autocmd("FileType", {
  group = augroup("setIndentTab", { clear = true }),
  pattern = { "go", "make" },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})

autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("setShebangFiletype", { clear = true }),
  pattern = "*",
  callback = function(args)
    if vim.bo[args.buf].filetype ~= "" then
      return
    end

    local first_line = vim.api.nvim_buf_get_lines(args.buf, 0, 1, false)[1] or ""
    if first_line:match("^#!.*%f[%w]bash%f[%W]") or first_line:match("^#!.*%f[%w]zsh%f[%W]") then
      vim.bo[args.buf].filetype = "bash"
    elseif first_line:match("^#!.*%f[%w]python[%w%.]*%f[%W]") then
      vim.bo[args.buf].filetype = "python"
    elseif first_line:match("^#!.*%f[%w]ruby%f[%W]") then
      vim.bo[args.buf].filetype = "ruby"
    end
  end,
})

autocmd("FileType", {
  group = augroup("markdownSpell", { clear = true }),
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.spell = false
  end,
})
