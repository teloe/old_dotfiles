local Type = {GLOBAL_OPTION = "o", WINDOW_OPTION = "wo", BUFFER_OPTION = "bo"}

local add_options = function(option_type, options)
    if type(options) ~= "table" then
        error 'options should be a type of "table"'
        return
    end
    local vim_option = vim[option_type]
    for key, value in pairs(options) do
        vim_option[key] = value
    end
end

local Option = {}

Option.g = function(options)
    add_options(Type.GLOBAL_OPTION, options)
end

Option.w = function(options)
    add_options(Type.WINDOW_OPTION, options)
end

Option.b = function(options)
    add_options(Type.BUFFER_OPTION, options)
end

Option.g {
    -- scrolloff = 999,
    termguicolors = true,
    mouse = "a",
    clipboard = "unnamedplus",
    hidden = true,
    -- showmode = false,
    -- timeoutlen = 3e3,
    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    -- conceallevel = 0,
    laststatus = 2,
    wrap = true,
    linebreak = true,
    list = true,
    listchars = "tab:»·,trail:·",
    wildmenu = true,
    wildmode = "full",
    autoread = true,
    -- updatetime = 500,
    -- redrawtime = 500,
    -- fillchars = vim.o.fillchars .. "vert:│",
    undofile = true,
    swapfile = false,
    splitbelow = true,
    showmatch = false
}

Option.b {
    swapfile = false,
    shiftwidth = 4,
    indentexpr="nvim_treesitter#indent()"
}

Option.w {
    number = true,
    numberwidth = 1,
    signcolumn = "yes",
    spell = false,
    foldlevel = 99,
    foldmethod = "marker",
    foldmarker = '{,}',
    foldexpr = "nvim_treesitter#foldexpr()",
    foldtext = "v:lua.foldText()",
    linebreak = true
}
-- vim.g.clipboard = {
--     name = "macOS-clipboard",
--     copy = {["+"] = "pbcopy", ["*"] = "pbcopy"},
--     paste = {["+"] = "pbpaste", ["*"] = "pbpaste"},
--     cache_enabled = false
-- }

vim.g.mapleader = ","
vim.g.markdown_fold_override_foldtext = false

return Option
