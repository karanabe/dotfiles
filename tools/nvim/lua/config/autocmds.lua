-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local indent_group = augroup("UserIndent", { clear = true })

local function set_indent(pattern, width, expandtab)
  autocmd("FileType", {
    group = indent_group,
    pattern = pattern,
    callback = function()
      if expandtab ~= nil then
        vim.opt_local.expandtab = expandtab
      end
      vim.opt_local.shiftwidth = width
      vim.opt_local.tabstop = width
    end,
  })
end

autocmd("FileType", {
  group = augroup("UserTextDisplay", { clear = true }),
  pattern = { "text", "markdown" },
  callback = function()
    vim.opt_local.colorcolumn = "0"
  end,
})

set_indent({
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
  "sh",
  "bash",
  "zsh",
}, 2)

set_indent({ "python", "rust" }, 4)

set_indent({ "go", "make" }, 4, false)

autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("UserShebangFiletype", { clear = true }),
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
  group = augroup("UserMarkdownSpell", { clear = true }),
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.spell = false
  end,
})
