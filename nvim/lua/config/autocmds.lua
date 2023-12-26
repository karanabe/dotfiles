-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand

-- shiftwidth <TAB> or <BS> space count
-- tabstop view for tab \0x09
-- softtabstop <TAB> or <BS> space count (vim original)
-- expandtab or noexpandtab

-- Disable line length marker
augroup('setLineLength', { clear = true })
autocmd('Filetype', {
  group = 'setLineLength',
  pattern = { 'text', 'markdown' },
  command = 'setlocal cc=0'
})

-- Set indentation to 2 spaces
augroup('setIndent2', { clear = true })
autocmd('Filetype', {
  group = 'setIndent2',
  pattern = { 'xml', 'html', 'xhtml', 'css', 'scss', 'javascript', 'typescript',
    'yaml', 'lua', 'java', 'c', 'cc', 'h', 'ruby', 'bash'
  },
  command = 'setlocal shiftwidth=2 tabstop=2'
})

-- Set indentation to 4 spaces
augroup('setIndent4', { clear = true })
autocmd('Filetype', {
  group = 'setIndent4',
  pattern = { 'python', 'rust' },
  command = 'setlocal shiftwidth=4 tabstop=4'
})

-- Set indentation to tab
augroup('setIndentTab', { clear = true })
autocmd('Filetype', {
  group = 'setIndentTab',
  pattern = { 'go', 'make' },
  command = 'setlocal noexpandtab shiftwidth=4 abstop=4'
})


vim.cmd([[autocmd BufNewFile,BufRead *.jsx setlocal shiftwidth=2 tabstop=2]])
vim.cmd([[autocmd BufNewFile,BufRead *.tsx setlocal shiftwidth=2 tabstop=2]])

vim.cmd([[autocmd BufRead,BufNewFile * nested if @% !~ '\.' && getline(1) == '^#!/bin/bash.*' | set filetype=bash | endif]])
vim.cmd([[autocmd BufRead,BufNewFile * nested if @% == '\.' | set filetype=bash | endif]])
vim.cmd([[autocmd BufRead,BufNewFile * nested if @% !~ '\.' && getline(1) == '^#!.*python.*' | set filetype=python | endif]])
vim.cmd([[autocmd BufRead,BufNewFile * nested if @% !~ '\.' && getline(1) == '^#!.*ruby.*' | set filetype=ruby | endif]])
vim.cmd([[autocmd BufRead,BufNewFile * nested if @% !~ '\.' && getline(1) == '^#!/bin/zsh.*' | set filetype=bash | endif]])
