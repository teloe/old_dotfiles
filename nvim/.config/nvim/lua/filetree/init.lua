local vim = vim
local nvim-tree = require"nvim-tree"

vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_indent_markers = 1

nvim-tree.setup {
    auto_close = true,
}
