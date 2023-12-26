return {
  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
      {
        "<leader>ff",
        function() require("telescope.builtin").find_files() end,
        desc = "Find Srouce File",
      },
      {
        "<leader>fg",
        function() require("telescope.builtin").live_grep() end,
        desc = "Find File from Words",
      },
      {
        "<leader>fb",
        function() require("telescope.builtin").buffer() end,
        desc = "Find File from Buffer",
      },
      {
        "<leader>fh",
        function() require("telescope.builtin").help_tags() end,
        desc = "Find Help Tags",
      }
      
    },
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
}
