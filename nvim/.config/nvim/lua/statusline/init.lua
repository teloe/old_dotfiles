local lualine = require "lualine"

-- Custom colorscheme
-- local colors = {
--     blue   = "#000000",
--     cyan   = "#000000",
--     black  = "#080808",
--     white  = "#000000",
--     red    = "#000000",
--     violet = "#000000",
--     grey   = "#303030",
-- }
-- 
-- local custom = {
--     normal = {
--         a = { fg = colors.grey, bg = colors.blue },
--         b = { fg = colors.white, bg = colors.black },
--         c = { fg = colors.white, bg = colors.grey },
--     },
-- 
--     insert = { a = { fg = colors.black, bg = colors.blue } },
--     visual = { a = { fg = colors.black, bg = colors.cyan } },
--     replace = { a = { fg = colors.black, bg = colors.red } },
-- 
--     inactive = {
--         a = { fg = colors.white, bg = colors.black },
--         b = { fg = colors.white, bg = colors.black },
--         c = { fg = colors.black, bg = colors.black },
--     },
-- }

lualine.setup(
{
    options = {
        -- theme = custom,
        -- theme = "nord",
        component_separators = "|",
        -- section_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = " " },
        section_separators = { left = "", right = "" },
    },
    sections = {
        lualine_a = {
            -- { 'mode', separator = { left = '' }, right_padding = 2 },
        },
        lualine_b = {
            -- {"branch", icon = ""},
            {"branch", icon = ""},
            {
                "diff",
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
