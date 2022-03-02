--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
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
lvim.keys.normal_mode["<Leader>bs"] = ":Telescope buffers<cr>"
lvim.keys.normal_mode["<Leader>gm"] = ":Git commit %<cr>"
for i=1,9 do
  local key = string.format("<A-%s>", i)
  local value = string.format(":BufferGoto %s<CR>" , i)
  lvim.keys.normal_mode[key] = value
end
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.dap.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "css",
  "rust",
  "java",
  "yaml",
"go","vue","javascript","html",
  "lua","json","bash","c","toml","dockerfile",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

---@usage disable automatic installation of servers
lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheRest` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

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
-- lvim.lsp.null_ls.setup.root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules")
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

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  -- { exe = "python", filetypes = { "json" },
  --   command = { "/usr/bin/python" },
  --   args = { "-m", "json.tool" },
  -- },
  { exe = "black", filetypes = { "python" } },
  -- { exe = "isort", filetypes = { "python" } },
  -- {
  --   exe = "prettier",
  --   ---@usage arguments to pass to the formatter
  --   -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
  --   args = { "--print-with", "100" },
  --   ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  --   filetypes = { "typescript", "typescriptreact" },
  -- },
}

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { exe = "flake8", filetypes = { "python" } },
--   {
--     exe = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     args = { "--severity", "warning" },
--   },
--   {
--     exe = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
-- lvim.plugins = {
--     {"folke/tokyonight.nvim"},
--     {
--       "folke/trouble.nvim",
--       cmd = "TroubleToggle",
--     },
-- }

local dap = require('dap')
dap.adapters.go = {
	type = 'executable';
	command = '/home/muxueqz/go/bin/dlv';
	args = {'debug'};
}
require('dap.ext.vscode').load_launchjs()


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
      vim.g.nvim_nim_enable_default_binds = 0
    local opts = {cmd={
        "nimlsp",
        "/data/work/projects/nim-src/",
      }}
    require("lspconfig")["nimls"].setup(opts)
    vim.api.nvim_set_keymap("n", "gd", ":Telescope lsp_definitions<cr>", { silent = true })
    vim.api.nvim_set_keymap("n", "gr", ":Telescope lsp_references<cr>", { silent = true })
    end,
  },
  -- {
  --   "stefanos82/nelua.vim",
  --   ft = "nelua",
  --   config = function()
  --   -- local opts = {cmd={
  --   --     "/dev/shm/temp-workspaces/nelua-lsp/nelua-lsp.sh"
  --   --   }}
  --   -- local configs = require 'lspconfig.configs'
  --   --  -- Check if the config is already defined (useful when reloading this file)
  --   --  if not configs.nelua_lsp then
  --   --    configs.nelua_lsp = {
  --   --      default_config = {
  --   --       cmd = {
  --   --           "/dev/shm/temp-workspaces/nelua-lsp/nelua-lsp.sh"
  --   --         };
  --   --        filetypes = {'nelua'};
  --   --        root_dir = function(fname)
  --   --          return lspconfig.util.find_git_ancestor(fname)
  --   --        end;
  --   --        settings = {};
  --   --      };
  --   --    }
  --   --  end
  --   -- require("lspconfig")["nelua_lsp"].setup(opts)
  --   -- lspconfig.nelua_lsp.setup()
  --   end,
  -- },
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
