local fn = vim.fn
local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
end

return require("packer").startup(function(use)
    -- Packer can manage itself
    use "wbthomason/packer.nvim"
    use "nvim-lua/plenary.nvim"

    -- General
    use "tpope/vim-repeat"
    use "tpope/vim-unimpaired"
    use "AndrewRadev/switch.vim"
    use "christoomey/vim-tmux-navigator"
    use "tpope/vim-surround"
    use "junegunn/vim-easy-align"

    -- Commenting
    use "terrortylor/nvim-comment"
    require("nvim_comment").setup({
        hook = function()
            if vim.api.nvim_buf_get_option(0, "filetype") == "vue" then
                require("ts_context_commentstring.internal").update_commentstring()
            end
        end
    })
    use "JoosepAlviste/nvim-ts-context-commentstring"

    -- Filetree
    use "kyazdani42/nvim-tree.lua"

    use "nvim-telescope/telescope.nvim"
    use "akinsho/toggleterm.nvim"
    use "nvim-treesitter/nvim-treesitter"
    use "romgrk/barbar.nvim"
    use "nvim-lualine/lualine.nvim"

    use "kyazdani42/nvim-web-devicons"

    -- LSP
    use "neovim/nvim-lspconfig"
    use "hrsh7th/nvim-compe"
    use "glepnir/lspsaga.nvim"

    -- Colors
    use "flazz/vim-colorschemes"
    use "habamax/vim-bronzage"

    -- Git
    use "tpope/vim-fugitive"
    use "lewis6991/gitsigns.nvim"

    -- HTML
    use "mattn/emmet-vim"

    -- Automatically set up configuration after cloning packer.nvim
    if packer_bootstrap then
        require("packer").sync()
    end
end)
