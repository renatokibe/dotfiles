-- Plugin specifications for lazy.nvim
-- All plugins from vimrc converted to lazy.nvim format

return {
  -- LSP and language servers
  { "williamboman/mason.nvim", config = require("plugins.config.mason").setup },
  { "williamboman/mason-lspconfig.nvim", dependencies = { "williamboman/mason.nvim" } },
  { "neovim/nvim-lspconfig", dependencies = { "williamboman/mason-lspconfig.nvim" } },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "zbirenbaum/copilot-cmp",
    },
    config = require("plugins.config.cmp").setup,
  },
  { "rafamadriz/friendly-snippets" },
  { "wellle/tmux-complete.vim" },

  -- UI enhancements
  {
    "utilyre/barbecue.nvim",
    dependencies = { "SmiteshP/nvim-navic", "kyazdani42/nvim-web-devicons" },
    config = require("plugins.config.barbecue").setup,
  },
  { "ray-x/lsp_signature.nvim" },
  { "folke/lsp-colors.nvim" },
  { "onsails/lspkind-nvim" },
  { "RRethy/vim-illuminate" },
  { "kosayoda/nvim-lightbulb" },
  { "nvim-lua/plenary.nvim" },
  { "glepnir/lspsaga.nvim" },
  {
    "folke/trouble.nvim",
    config = require("plugins.config.trouble").setup,
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = require("plugins.config.fzf_lua").setup,
  },
  { "mfussenegger/nvim-jdtls" },
  { "j-hui/fidget.nvim", opts = {} },

  -- Git integration
  { "tpope/vim-fugitive" },
  { "tpope/vim-rhubarb" },
  {
    "lewis6991/gitsigns.nvim",
    config = require("plugins.config.gitsigns").setup,
  },

  -- Tpope utilities
  { "tpope/vim-repeat" },
  { "tpope/vim-unimpaired" },
  { "tpope/vim-abolish" },
  { "tpope/vim-surround" },
  { "tpope/vim-commentary" },

  -- Icons
  { "kyazdani42/nvim-web-devicons" },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    config = require("plugins.config.nordevil_lualine").setup,
  },

  -- Color schemes
  { "morhetz/gruvbox" },
  { "jacoborus/tender.vim" },
  { "junegunn/seoul256.vim" },
  { "shaunsingh/nord.nvim" },
  { "ayu-theme/ayu-vim" },
  { "tjdevries/colorbuddy.nvim" },
  { "andersevenrud/nordic.nvim" },
  { "sainnhe/everforest" },

  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "s1n7ax/nvim-window-picker",
    },
    config = require("plugins.config.neo_tree").setup,
  },
  { "MunifTanjim/nui.nvim" },
  { "s1n7ax/nvim-window-picker", config = require("plugins.config.window_picker").setup },

  -- Tmux integration
  { "christoomey/vim-tmux-navigator" },

  -- Language specific
  { "vim-ruby/vim-ruby", ft = "ruby" },
  { "tpope/vim-rails", ft = "ruby" },
  { "kana/vim-textobj-user" },
  { "nelstrom/vim-textobj-rubyblock", ft = "ruby", dependencies = { "kana/vim-textobj-user" } },
  { "ecomba/vim-ruby-refactoring", ft = "ruby" },
  { "tpope/vim-markdown", ft = "html" },
  { "elzr/vim-json", ft = "json" },
  { "kevinoid/vim-jsonc", ft = { "json", "jsonc" } },
  { "othree/html5.vim" },
  { "vim-perl/vim-perl", ft = "perl" },
  { "Vimjas/vim-python-pep8-indent", ft = "python" },
  { "vim-python/python-syntax", ft = "python" },
  { "StanAngeloff/php.vim", ft = "php" },
  { "airblade/vim-localorie", ft = "ruby" },

  -- Utilities
  { "pbrisbin/vim-mkdir" },
  { "junegunn/fzf" },
  { "junegunn/fzf.vim" },
  { "mg979/vim-visual-multi" },
  { "michaeljsmith/vim-indent-object" },
  { "tpope/vim-eunuch" },
  { "ntpeters/vim-better-whitespace" },
  { "thirtythreeforty/lessspace.vim" },
  { "mhinz/vim-startify" },
  { "editorconfig/editorconfig-vim" },
  { "gioele/vim-autoswap" },
  { "junegunn/goyo.vim", ft = { "markdown", "txt", "text" } },
  { "lambdalisue/suda.vim" },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = require("plugins.config.treesitter").setup,
  },
  { "nvim-treesitter/playground" },
  { "JoosepAlviste/nvim-ts-context-commentstring" },
  { "RRethy/nvim-treesitter-textsubjects" },
  { "RRethy/nvim-treesitter-endwise" },

  -- Editing enhancements
  { "andymass/vim-matchup" }, -- Enhanced % matching with treesitter support
  {
    "windwp/nvim-autopairs",
    config = require("plugins.config.autopairs").setup,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = require("plugins.config.indent_blankline").setup,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = require("plugins.config.colorizer").setup,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = require("plugins.config.todo_comments").setup,
  },

  -- Debug Adapter Protocol
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
  { "theHamsta/nvim-dap-virtual-text" },

  -- AI assistance
  {
    "zbirenbaum/copilot.lua",
    config = require("plugins.config.copilot").setup,
  },
  { "zbirenbaum/copilot-cmp" },
  { "CopilotC-Nvim/CopilotChat.nvim", branch = "main" },
  {
    "olimorris/codecompanion.nvim",
    config = require("plugins.config.codecompanion").setup,
  },

  -- Markdown rendering
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = require("plugins.config.render_markdown").setup,
  },

  -- HTML utilities
  { "mattn/emmet-vim" },
}
