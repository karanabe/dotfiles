return {
  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = function(_, keys)
      -- remove LazyVim's default <leader>fg -> git_files mapping
      for i = #keys, 1, -1 do
        if keys[i][1] == "<leader>fg" then
          table.remove(keys, i)
        end
      end
       vim.list_extend(keys, {
        {
          "<leader>fp",
          function()
            require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
          end,
          desc = "Find Plugin File",
        },
        {
          "<leader>ff",
          function() require("telescope.builtin").find_files() end,
          desc = "Find Source File",
        },
        {
          "<leader>fg",
          function() require("telescope.builtin").live_grep() end,
          desc = "Live Grep",
        },
        {
          "<leader>fb",
          function() require("telescope.builtin").buffers() end,
          desc = "Find File from Buffer",
        },
        {
          "<leader>fh",
          function() require("telescope.builtin").help_tags() end,
          desc = "Find Help Tags",
        },
      })
       return keys
    end,
    -- change some options
    opts = {
      defaults = {
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
      },
    },
  },

  -- add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },

  -- add telescope-coc
  {
    'fannheyward/telescope-coc.nvim',
    config = function ()
      require('telescope').load_extension("coc")
    end,
  },

  -- add telescope-luasnip
  {
    "benfowler/telescope-luasnip.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      require("telescope").load_extension("luasnip")

      vim.keymap.set("n", "<leader><leader>ls", function()
        require("telescope").extensions.luasnip.luasnip()
      end, { desc = "List LuaSnip snippets" })
    end,
  },
}
