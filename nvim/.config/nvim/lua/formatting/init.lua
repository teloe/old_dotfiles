local null_ls = require"null-ls"
local formatting = require("null-ls").builtins.formatting
local diagnostics = require("null-ls").builtins.diagnostics
local completion = require("null-ls").builtins.completion

null_ls.setup({
    sources = {
        formatting.prettier,
        formatting.stylua,
        diagnostics.eslint,
        completion.spell,
    },

    on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
            vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
        end
    end,
})
