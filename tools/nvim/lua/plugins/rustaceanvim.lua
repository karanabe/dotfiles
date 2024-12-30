return {
  {
    'rust-lang/rust.vim',
    init = function ()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
    init = function()
      local mason_registry = require 'mason-registry'
      local codelldb_root = mason_registry.get_package("codelldb"):get_install_path() .. "/extension/"
      local codelldb_path = codelldb_root .. "adapter/codelldb"
      local liblldb_path = codelldb_root .. "lldb/lib/liblldb.so"
      local cfg = require 'rustaceanvim.config'

      ---@type RustaceanOpts
      vim.g.rustaceanvim = {
        bufnr = vim.api.nvim_get_current_buf(),

        ---@type RustaceanToolsOpts
        tools = {
          
          hover_actions = {
            -- Maximal width of the hover window. Nil means no max.
            max_width = nil,

            -- Maximal height of the hover window. Nil means no max.
            max_height = nil,

            -- whether the hover action window gets automatically focused
            -- default: false
            auto_focus = false,
          },
        },
        ---@type RustaceanLspClientOpts
        server = {
          on_attach = function(_, bufnr)
            -- some key bind
          end,
          standalone = true,
          flags = {
            debounce_text_changes = 150,
          },
          settings = {
            ["rust_analyzer"] = {
              checkOnSave = { enable = true, command = 'clippy' },
              cargo = { allFeatures = true },
              inlayHints = { allFeatures = true },
            },
          },
        },
        ---@type RustaceanDapOpts
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
    end,
  },
}
