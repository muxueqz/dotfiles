-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "onedarker"
vim.cmd [[
  set nofoldenable
]]

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- lvim.keys.normal_mode["<F5>"] = ":buffers<CR>:buffer<Space>"
lvim.keys.normal_mode["<F5>"] = ":Telescope buffers<cr>"
lvim.keys.normal_mode["<Leader>gm"] = ":Git commit %<cr>"
for i=1,9 do
  local key = string.format("<A-%s>", i)
  local value = string.format(":BufferGoto %s<CR>" , i)
  lvim.keys.normal_mode[key] = value
end
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = ""
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- lvim.builtin.telescope.on_config_done = function()
--   local actions = require "telescope.actions"
--   -- for input mode
--   lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = actions.move_selection_next
--   lvim.builtin.telescope.defaults.mappings.i["<C-k>"] = actions.move_selection_previous
--   lvim.builtin.telescope.defaults.mappings.i["<C-n>"] = actions.cycle_history_next
--   lvim.builtin.telescope.defaults.mappings.i["<C-p>"] = actions.cycle_history_prev
--   -- for normal mode
--   lvim.builtin.telescope.defaults.mappings.n["<C-j>"] = actions.move_selection_next
--   lvim.builtin.telescope.defaults.mappings.n["<C-k>"] = actions.move_selection_previous
-- end

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnosticss" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnosticss" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.dap.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {"python","go","vue","javascript","html","css","typescript","lua","json","bash","c","toml","dockerfile","yaml"}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
-- you can overwrite the null_ls setup table (useful for setting the root_dir function)
-- lvim.lsp.null_ls.setup = {
--   root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules"),
-- }
-- or if you need something more advanced
-- lvim.lsp.null_ls.setup.root_dir = function(fname)
--   if vim.bo.filetype == "javascript" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
--       or require("lspconfig/util").path.dirname(fname)
--   elseif vim.bo.filetype == "php" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "composer.json")(fname) or vim.fn.getcwd()
--   else
--     return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or require("lspconfig/util").path.dirname(fname)
--   end
-- end

-- set a formatter if you want to override the default lsp one (if it exists)
-- lvim.lang.python.formatters = {
--   {
--     exe = "black",
--     args = {}
--   }
-- }
-- set an additional linter
-- lvim.lang.python.linters = {
--   {
--     exe = "flake8",
--     args = {}
--   }
-- }
-- exe value can be "gofmt", "goimports", or "gofumpt"

-- Additional Plugins
-- lvim.plugins = {
--     {"folke/tokyonight.nvim"}, {
--         "ray-x/lsp_signature.nvim",
--         config = function() require"lsp_signature".on_attach() end,
--         event = "InsertEnter"
--     }
-- }

-- dap.configuration.go = {
--  {
--     type = "go",
--     name = "Debug curr file",
--     request = "launch",
--     program = "${file}",
--     dlvToolPath = vim.fn.exepath('dlv')
--   },
-- }
-- lua require('dap.ext.vscode').load_launchjs()
local dap = require('dap')
dap.adapters.go = {
	type = 'executable';
	command = '/home/muxueqz/go/bin/dlv';
	args = {'debug'};
}
require('dap.ext.vscode').load_launchjs()

-- vim.list_extend(lvim.lsp.override, { "nimls" })
lvim.plugins = {
  -- {"wsdjeg/vim-nim"},
  -- {
  -- "plasticboy/vim-markdown",
  --   -- ft = "markdown",
  --   config = function()
  --     vim.g.markdown_folding_disabled = 1
  --     vim.cmd [[
  --       set nofoldenable
  --     ]]
  --   end,
  -- },
  {
    "wsdjeg/vim-nim",
    ft = "nim",
    config = function()
      -- require("lvim.lsp.manager").setup("nimls", {cmd={
      --   "nimlsp",
      --   "/data/work/projects/nim-src/",
      -- }}
      -- )
    local opts = {cmd={
        "nimlsp",
        "/data/work/projects/nim-src/",
      }}
    require("lspconfig")["nimls"].setup(opts)
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 1
      vim.cmd [[
        nmap <Space>mp <Plug>MarkdownPreview
      ]]
    end,
  },
  {
    "mattn/vim-gist",
    event = "BufRead",
    requires = "mattn/webapi-vim",
  },
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = {"fugitive"}
  },
  -- {
  --   'phaazon/hop.nvim',
  --   branch = 'v1', -- optional but strongly recommended
  --   config = function()
  --     -- you can configure Hop the way you like here; see :h hop-config
  --     require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
  --   end
  -- },
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "f", ":HopWord<cr>", { silent = true })
    end,
  },
  -- {
  --   "xavierchow/vim-swagger-preview",
  --   ft = "yaml",
  --   config = function()
  --     -- vim.cmd [[
  --     --   nmap <Space>mp <Plug>MarkdownPreview
  --     -- ]]
  --   end,
  -- },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
-- lvim.autocommands.custom_groups = {
  -- { "BufRead, BufNewFile", "*.nim", "set filetypets=nim" },
-- }
