local vim = vim
local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup {
    defaults = {
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        mappings = {
            i = {
                ["<esc>"] = actions.close,
                ["<CR>"] = actions.select_default,
                ["<Tab>"] = actions.toggle_selection
            }
        }
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    }
}


telescope.load_extension('fzy_native')
