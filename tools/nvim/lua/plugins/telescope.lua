return {
  {
    "nvim-telescope/telescope.nvim",
    keys = function(_, keys)
      local remove = {
        ["<leader>fb"] = true,
        ["<leader>ff"] = true,
        ["<leader>fg"] = true,
        ["<leader>fh"] = true,
        ["<leader>fp"] = true,
      }
      for i = #keys, 1, -1 do
        if remove[keys[i][1]] then
          table.remove(keys, i)
        end
      end
      vim.list_extend(keys, {
        {
          "<leader>fb",
          "<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=true<cr>",
          desc = "Buffers",
        },
        {
          "<leader>ff",
          LazyVim.pick("files"),
          desc = "Find Files (Root Dir)",
        },
        {
          "<leader>fg",
          LazyVim.pick("live_grep"),
          desc = "Live Grep (Root Dir)",
        },
        {
          "<leader>fh",
          "<cmd>Telescope help_tags<cr>",
          desc = "Find Help Tags",
        },
        {
          "<leader>fp",
          function()
            require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
          end,
          desc = "Find Plugin File",
        },
      })
      return keys
    end,
    opts = function(_, opts)
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "bottom" },
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
            ["<C-p>"] = "preview_scrolling_up",
            ["<C-n>"] = "preview_scrolling_down",
          },
        },
      })
    end,
  },

  {
    "benfowler/telescope-luasnip.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "L3MON4D3/LuaSnip",
    },
    keys = {
      {
        "<leader><leader>ls",
        function()
          require("telescope").extensions.luasnip.luasnip()
        end,
        desc = "List LuaSnip snippets",
      },
    },
    config = function()
      require("telescope").load_extension("luasnip")
    end,
  },
}
