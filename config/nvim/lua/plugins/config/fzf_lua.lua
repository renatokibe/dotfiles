local M = {}

M.setup = function()
  -- Set custom colors for fzf-lua to match Nordic theme
  local has_nordic, palette = pcall(require, 'nordic.palette')
  if has_nordic then
    vim.api.nvim_set_hl(0, 'FzfLuaNormal', { bg = palette.black1, fg = palette.white })
    vim.api.nvim_set_hl(0, 'FzfLuaBorder', { bg = palette.black1, fg = palette.blue })
    vim.api.nvim_set_hl(0, 'FzfLuaTitle', { bg = palette.black1, fg = palette.cyan, bold = true })
    vim.api.nvim_set_hl(0, 'FzfLuaPreviewNormal', { bg = palette.black0 })
    vim.api.nvim_set_hl(0, 'FzfLuaPreviewBorder', { bg = palette.black0, fg = palette.blue })
    vim.api.nvim_set_hl(0, 'FzfLuaCursor', { bg = palette.blue, fg = palette.black })
    vim.api.nvim_set_hl(0, 'FzfLuaCursorLine', { bg = palette.gray0 })
  end

  require("fzf-lua").setup({
    -- Use fzf-native for better performance
    fzf_bin = "fzf",
    defaults = {
      -- Global icons for all pickers
      git_icons = true,
      file_icons = true,
    },
    winopts = {
      height = 0.85,
      width = 0.85,
      row = 0.35,
      col = 0.50,
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      hls = {
        normal = "FzfLuaNormal",
        border = "FzfLuaBorder",
        title = "FzfLuaTitle",
        preview_normal = "FzfLuaPreviewNormal",
        preview_border = "FzfLuaPreviewBorder",
        cursor = "FzfLuaCursor",
        cursorline = "FzfLuaCursorLine",
      },
      preview = {
        border = "border",
        wrap = "nowrap",
        hidden = "nohidden",
        vertical = "down:50%",
        horizontal = "right:55%",
        layout = "flex",
        flip_columns = 120,
        scrollbar = "float",
        scrolloff = "-2",
        title = true,
        title_pos = "center",
      },
    },
    fzf_opts = {
      ["--ansi"] = true,
      ["--info"] = "inline-right",
      ["--height"] = "100%",
      ["--layout"] = "reverse",
      ["--border"] = "none",
      ["--highlight-line"] = true,
      ["--pointer"] = "▶",
      ["--marker"] = "✓",
      ["--prompt"] = "❯ ",
    },
    keymap = {
      builtin = {
        ["<F1>"] = "toggle-help",
        ["<F2>"] = "toggle-fullscreen",
        ["<F3>"] = "toggle-preview-wrap",
        ["<F4>"] = "toggle-preview",
        ["<F5>"] = "toggle-preview-ccw",
        ["<F6>"] = "toggle-preview-cw",
        ["<C-d>"] = "preview-page-down",
        ["<C-u>"] = "preview-page-up",
      },
      fzf = {
        ["ctrl-q"] = "select-all+accept",
      },
    },
    -- Override default split actions to match our h/v convention
    actions = {
      files = {
        ["ctrl-h"] = require("fzf-lua.actions").file_vsplit,  -- h = horizontal arrangement (side by side)
        ["ctrl-v"] = require("fzf-lua.actions").file_split,   -- v = vertical arrangement (top and bottom)
      },
    },
    previewers = {
      builtin = {
        syntax = true,
        syntax_limit_l = 0,
        syntax_limit_b = 1024 * 1024,
      },
    },
    files = {
      prompt = " Files❯ ",
      multiprocess = true,
      git_icons = true,
      file_icons = true,
      color_icons = true,
      cmd = "rg --files --hidden --follow",
      winopts = {
        title = " 📁 Find Files ",
        title_pos = "center",
      },
    },
    grep = {
      prompt = " Grep❯ ",
      input_prompt = " Search For❯ ",
      multiprocess = true,
      git_icons = true,
      file_icons = true,
      color_icons = true,
      -- Two-phase: search once, then fuzzy filter results
      rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
      winopts = {
        title = " 🔍 Grep (Two-Phase) ",
        title_pos = "center",
      },
    },
    live_grep = {
      prompt = " Live Grep❯ ",
      input_prompt = " Search For❯ ",
      multiprocess = true,
      git_icons = true,
      file_icons = true,
      color_icons = true,
      -- Interactive: updates as you type
      winopts = {
        title = " 🔍 Live Grep ",
        title_pos = "center",
      },
    },
    buffers = {
      prompt = " Buffers❯ ",
      file_icons = true,
      color_icons = true,
      winopts = {
        title = " 📋 Buffers ",
        title_pos = "center",
      },
    },
    oldfiles = {
      prompt = " History❯ ",
      file_icons = true,
      color_icons = true,
      winopts = {
        title = " 🕐 Recent Files ",
        title_pos = "center",
      },
    },
    lsp = {
      prompt_postfix = "❯ ",
      git_icons = false,
      file_icons = true,
      color_icons = true,
      code_actions = {
        prompt = " Code Actions❯ ",
        winopts = {
          title = " 💡 Code Actions ",
          title_pos = "center",
        },
      },
      symbols = {
        prompt = " Symbols❯ ",
        symbol_style = 1, -- 1: icon+kind, 2: icon only, 3: kind only
        winopts = {
          title = " 🔖 Symbols ",
          title_pos = "center",
        },
      },
      finder = {
        prompt = " LSP Finder❯ ",
        winopts = {
          title = " 🔎 LSP Finder ",
          title_pos = "center",
        },
      },
    },
    git = {
      files = {
        prompt = " GitFiles❯ ",
        cmd = "git ls-files --exclude-standard",
        winopts = {
          title = "  Git Files ",
          title_pos = "center",
        },
      },
      status = {
        prompt = " GitStatus❯ ",
        winopts = {
          title = "  Git Status ",
          title_pos = "center",
        },
      },
      commits = {
        prompt = " Commits❯ ",
        winopts = {
          title = "  Git Commits ",
          title_pos = "center",
        },
      },
      bcommits = {
        prompt = " BCommits❯ ",
        winopts = {
          title = "  Buffer Commits ",
          title_pos = "center",
        },
      },
      branches = {
        prompt = " Branches❯ ",
        winopts = {
          title = "  Git Branches ",
          title_pos = "center",
        },
      },
    },
    helptags = {
      prompt = " Help❯ ",
      winopts = {
        title = " 📖 Help Tags ",
        title_pos = "center",
      },
    },
  })
end

return M
