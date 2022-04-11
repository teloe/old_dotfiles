local vim = vim
local api = vim.api
local M = {}

function M.map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.mapBuf(buf, mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_buf_set_keymap(buf, mode, lhs, rhs, options)
end

M.map("n", "Q", "<nop>")
M.map("n", "q", "<nop>")

-- End of line while in insert mode
M.map("i", "<C-l>", "<C-o>A")

-- Quick save
M.map("n", "<Leader>s", ":update<cr>")

-- Toggle nvim-tree
M.map("n", "<Leader>n", ":NvimTreeToggle<cr>")

-- Barbar.nvim
M.map("n", "bp", ":BufferPrevious<cr>")
M.map("n", "bn", ":BufferNext<cr>")
M.map("n", "b<", ":BufferMovePrevious<cr>")
M.map("n", "b>", ":BufferMoveNext<cr>")
M.map("n", "bc", ":BufferClose<cr>")
M.map("n", "bh", ":BufferPick<cr>")
M.map("n", "bd", ":BufferOrderByDirectory<cr>")
M.map("n", "bl", ":BufferOrderByLanguage<cr>")
M.map("n", "b1", ":BufferGoto 1<cr>")
M.map("n", "b2", ":BufferGoto 2<cr>")
M.map("n", "b3", ":BufferGoto 3<cr>")
M.map("n", "b4", ":BufferGoto 4<cr>")
M.map("n", "b5", ":BufferGoto 5<cr>")
M.map("n", "b6", ":BufferGoto 6<cr>")
M.map("n", "b7", ":BufferGoto 7<cr>")
M.map("n", "b8", ":BufferGoto 8<cr>")
M.map("n", "b9", ":BufferGoto 9<cr>")

-- M.map("n", "<Leader>H", '<cmd>TSHighlightCapturesUnderCursor<cr>')
M.map("n", "<c-p>", "<cmd>lua require('telescope.builtin').find_files()<cr>")
M.map("n", "<Leader>h", "<cmd>lua require('telescope.builtin').help_tags()<cr>")
M.map("n", "<Leader>c", "<cmd>lua require('telescope.builtin').colorscheme()<cr>")
M.map("n", "<Leader>b", "<cmd>Telescope buffers<cr>")
M.map("n", "<Leader>a", "<cmd>Telescope live_grep<cr>")

M.map("n", "<Leader>f", "<cmd>Neoformat<cr>")

M.map("n", "H", "^")
M.map("n", "L", "g_")
M.map("v", "H", "^")
M.map("v", "L", "g_")
M.map("n", "J", "5j")
M.map("n", "K", "5k")
M.map("v", "J", "5j")
M.map("v", "K", "5k")
M.map("v", "gJ", ":join<cr>")
M.map("n", ";", ":", {nowait = true, silent = false})
M.map("n", "<Space>", "za")
M.map("v", "<Space>", "za")
M.map("n", "<Leader>,", "<cmd>bnext<cr>")
M.map("n", "<Leader>.", "<cmd>bprevious<cr>")

M.map("n", "k", "v:count == 0 ? 'gk' : 'k'", {expr = true})
M.map("n", "j", "v:count == 0 ? 'gj' : 'j'", {expr = true})
M.map("v", "k", "v:count == 0 ? 'gk' : 'k'", {expr = true})
M.map("v", "j", "v:count == 0 ? 'gj' : 'j'", {expr = true})

M.map("v", "<", "<gv")
M.map("v", ">", ">gv")
M.map("n", "<Leader>d", '"_d')
M.map("v", "<Leader>d", '"_d')
M.map("n", "<Esc>", "<cmd>noh<cr>")
-- terminal M.mappings
-- M.map("t", "<Esc>", "<c-\\><c-n><esc><cr>")
-- M.map("t", "<Leader>,", "<c-\\><c-n>:bnext<cr>")
-- M.map("t", "<Leader>.", "<c-\\><c-n>:bprevious<cr>")

M.map("n", "<Leader>tm", "<cmd>TableModeToggle<cr>")
M.map("n", "<Leader>u", "<cmd>PackerUpdate<cr>")

for i = 1, 9 do
    M.map("n", "<leader>" .. i, ':lua require"bufferline".go_to_buffer(' .. i .. ")<CR>")
    M.map("t", "<leader>" .. i, '<C-\\><C-n>:lua require"bufferline".go_to_buffer(' .. i .. ")<CR>")
end

vim.cmd("cnoreabbrev x Sayonara")

return M
