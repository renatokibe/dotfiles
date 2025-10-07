-- NordEviline config for lualine roughly based on eviline from shadmansaleh
-- Author: kibe
-- Credit: shadmansaleh, glepnir
--
local lualine = require 'lualine'
local palette = require 'nordic.palette'

-- Color table for highlights
local nord_colors = {
    bg = palette.black,
    fg = palette.dark_white,
    yellow = palette.yellow,
    cyan = palette.cyan,
    darkblue = palette.dark_blue,
    green = palette.green,
    orange = palette.orange,
    violet = palette.purple,
    magenta = palette.purple,
    blue = palette.blue,
    red = palette.red
}

local configuration = vim.fn['everforest#get_configuration']()
local everforest_palette = vim.fn['everforest#get_palette'](configuration.background, configuration.colors_override)

local everforest_colors = {
    bg = everforest_palette.bg0[1],
    fg = everforest_palette.fg[1],
    yellow = everforest_palette.yellow[1],
    cyan = everforest_palette.aqua[1],
    darkblue = everforest_palette.blue[1],
    green = everforest_palette.green[1],
    orange = everforest_palette.orange[1],
    violet = everforest_palette.purple[1],
    magenta = everforest_palette.purple[1],
    blue = everforest_palette.blue[1],
    red = everforest_palette.red[1]
}

local colors = everforest_colors


local is_medium_screen = function() return not (vim.fn.winwidth(0) < 120) end

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,
    hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
    is_medium_screen = is_medium_screen,
    check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
    get_path_options = function()
      if is_medium_screen() then
      return 1
      else
        return 0
      end
    end
}

-- Config
local config = {
    options = {
        disabled_filetypes = {
            'NvimTree', 'dbui', 'packer', 'startify', 'fugitive',
            'fugitiveblame', 'neo-tree'
        },
        -- Disable sections and component separators
        component_separators = "",
        section_separators = "",
        -- theme = 'everforest'
        theme = {
            -- We are going to use lualine_c an lualine_x as left and
            -- right section. Both are highlighted by c theme .  So we
            -- are just setting default looks o statusline
            normal = {c = {fg = colors.fg, bg = colors.bg}},
            inactive = {c = {fg = colors.fg, bg = colors.bg}}

        }
    },
    sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {}
    },
    inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_v = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {}
    }
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
    table.insert(config.inactive_sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
    table.insert(config.inactive_sections.lualine_x, component)
end

ins_left {
    function() return '▊' end,
    color = {fg = colors.blue}, -- Sets highlighting of component
    left_padding = 0 -- We don't need space before this
}

ins_left {
    -- mode component
    function()
        -- auto change color according to neovims mode
        local mode_color = {
            n = colors.red,
            i = colors.green,
            v = colors.blue,
            [''] = colors.blue,
            V = colors.blue,
            c = colors.magenta,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [''] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ['r?'] = colors.cyan,
            ['!'] = colors.red,
            t = colors.red
        }
        vim.api.nvim_command('hi! LualineMode guifg=' ..
                                 mode_color[vim.fn.mode()] .. " guibg=" ..
                                 colors.bg)
        return ''
    end,
    color = "LualineMode",
    left_padding = 0
}

ins_left {
    -- filesize component
    function()
        local function format_file_size(file)
            local size = vim.fn.getfsize(file)
            if size <= 0 then return '' end
            local sufixes = {'b', 'k', 'm', 'g'}
            local i = 1
            while size > 1024 do
                size = size / 1024
                i = i + 1
            end
            return string.format('%.1f%s', size, sufixes[i])
        end
        local file = vim.fn.expand('%:p')
        if string.len(file) == 0 then return '' end
        return format_file_size(file)
    end,
    condition = conditions.buffer_not_empty
}

ins_left {
    'filename',
    condition = conditions.buffer_not_empty,
    path = conditions.get_path_options(),
    -- icon = "",
    -- icon = "",
    icon = "",
    color = {fg = colors.magenta, gui = 'bold'}
}

ins_left {'location'}

ins_left {'progress', color = {fg = colors.blue, gui = 'bold'}}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
-- ins_left {function() return '%=' end}

ins_left {
    'diagnostics',
    sources = {'nvim_diagnostic'},
    symbols = {error = ' ', warn = ' ', info = ' '},
    color_error = colors.red,
    color_warn = colors.yellow,
    color_info = colors.cyan
}

ins_left {
    -- Lsp server name .
    function()
        local clients = {}
        local icon = ' '
        local default_msg = icon .. 'no language servers found'

        for _, client in pairs(vim.lsp.get_clients()) do
            clients[#clients + 1] = icon .. client.name
        end

        if type(next(clients)) == "nil" then return default_msg end

        return table.concat(clients, ' ')
    end,
    color = {fg = colors.cyan, gui = 'bold'}
}

-- Add components to right sections
ins_right {
    'o:encoding', -- option component same as &encoding in viml
    upper = false, -- I'm not sure why it's upper case either ;)
    condition = conditions.hide_in_width,
    color = {fg = colors.green, gui = 'bold'}
}

ins_right {
    'fileformat',
    upper = false,
    icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
    color = {fg = colors.green, gui = 'bold'}
}

ins_right {
    'branch',
    -- icon = '',
    -- icon = '',
    icon = '',
    condition = conditions.check_git_workspace,
    color = {fg = colors.violet, gui = 'bold'}
}

ins_right {
    'diff',
    -- Is it me or the symbol for modified us really weird
    symbols = {added = ' ', modified = '柳 ', removed = ' '},
    color_added = colors.green,
    color_modified = colors.orange,
    color_removed = colors.red,
    condition = conditions.hide_in_width
}

ins_right {
    function() return '▊' end,
    color = {fg = colors.blue},
    right_padding = 0
}

-- Now don't forget to initialize lualine
lualine.setup(config)
