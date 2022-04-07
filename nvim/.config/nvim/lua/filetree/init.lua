local vim = vim
local nvimtree = require"nvim-tree"

vim.g.nvim_tree_indent_markers = 1

nvimtree.setup {
    -- auto_close = true,
    actions = {
        open_file = {
            quit_on_open = true,
            resize_window = false,
        },
    },
}
