-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- leader
vim.g.mapleader = " "

local mapset = vim.keymap.set

-- jj
mapset("i", "jj", "<ESC>", { silent = true })

-- Key ignore
mapset("n", "<leader><space>", "<nop>", {})

-- key changes
-- mapset("n", "o", "O", { desc = "Insert current line" })
-- mapset("n", "O", "o", { desc = "Insert bottom line" })

-- Move to window using the <ctrl> hjkl keys
mapset("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
mapset("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
mapset("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
mapset("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
mapset("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
mapset("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
mapset("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
mapset("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Clear search with <esc>
mapset({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- buffers
mapset("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
mapset("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
mapset("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
mapset("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- tabs
mapset("n", "<leader>tl", "<cmd>tablast<cr>", { desc = "Last Tab" })
mapset("n", "<leader>tf", "<cmd>tabfirst<cr>", { desc = "First Tab" })
mapset("n", "<leader>tc", "<cmd>tabnew<cr>", { desc = "New Tab" })
mapset("n", "<leader>tl", "<cmd>tabnext<cr>", { desc = "Next Tab" })
mapset("n", "<leader>td", "<cmd>tabclose<cr>", { desc = "Close Tab" })
mapset("n", "<leader>th", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- windows
mapset("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
mapset("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
mapset("n", "q", "<C-W>c", { desc = "Delete window", remap = true })
mapset("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
mapset("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
mapset("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
mapset("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })

-- rustaceanvim
mapset("n", "<leader>rt", "<cmd>RustLsp testables<cr>", { desc = "Rust Testable", remap = true })
mapset("n", "<leader>rr", "<cmd>RustLsp runnables<cr>", { desc = "Rust Runnable", remap = true })
mapset("n", "<leader>re", "<cmd>RustLsp explainError<cr>", { desc = "Rust Explain Error", remap = true })
mapset("n", "<leader>rd", "<cmd>RustLsp renderDiagnostic<cr>", { desc = "Rust Diagnostic", remap = true })
mapset("n", "<leader>rc", "<cmd>RustLsp codeAction<cr>", { desc = "Rust Code Action", remap = true })

-- カーソルのある行の末尾にセミコロンを追加する関数
function InsertEndSemicolon()
  -- カーソルの現在位置を取得する
  local currentPosition = vim.api.nvim_win_get_cursor(0)

  -- 行末にセミコロンがなかったら挿入する
  local line = vim.api.nvim_get_current_line()
  if not line:match(";$") then
    vim.api.nvim_set_current_line(line .. ";")
  end

  -- カーソル位置を戻す
  vim.api.nvim_win_set_cursor(0, currentPosition)
end

-- mapset("n", ";", "<cmd>lua InsertEndSemicolon()<cr>", { noremap = true, silent = true })
mapset("i", ";;", "<cmd>lua InsertEndSemicolon()<cr>", { noremap = true, silent = true })
mapset("i", ";j", "<cmd>lua InsertEndSemicolon()<cr><ESC>", { noremap = true, silent = true })
