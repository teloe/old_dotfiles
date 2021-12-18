local lualine = require "lualine"

lualine.setup(
{
    options = {
        component_separators = '|',
        section_separators = { left = '', right = '' },
        -- section_separators = { left = '', right = ' ' },
    },
    sections = {
        lualine_a = {
            -- { 'mode', separator = { left = '' }, right_padding = 2 },
        },
        lualine_b = {
            {'branch', icon = ""},
            {
                'diff',
                symbols = {
                    added    = " ",
                    modified = " ",
                    removed  = " "
                }
            }
        },
        lualine_c = {"filename"},
        lualine_x = {"b:gitsigns_status"},
        lualine_y = {"filetype"},
        lualine_z = {
            "location",
            {
                "diagnostics",
                sources = {"nvim_diagnostic"},
                symbols = {error = " ", warn = " ", info = " "}
            }
        }
    }
}
)
