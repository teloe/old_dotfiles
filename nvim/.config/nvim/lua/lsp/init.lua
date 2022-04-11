local vim = vim
local lspconfig = require"lspconfig"
local configs = require"lspconfig.configs"
local cmp = require"cmp"

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Vim-vsnip
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

-- Nvim-comp setup
cmp.setup {

    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },

    mapping = {
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
                feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            end
        end, { "i", "s" }),
    },

    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "vsnip" },
    }, {
        { name = "buffer" },
    })
}

if not configs.ls_emmet then
    configs.ls_emmet = {
        default_config = {
            cmd = { 'ls_emmet', '--stdio' };
            filetypes = {
                'html',
                'css',
                'scss',
                'javascript',
                'javascriptreact',
                'typescript',
                'typescriptreact',
                'haml',
                'xml',
                'xsl',
                'pug',
                'slim',
                'sass',
                'stylus',
                'less',
                'sss',
                'hbs',
                'handlebars',
            };
            root_dir = function(fname)
                return vim.loop.cwd()
            end;
            settings = {};
        };
    }
end

lspconfig.ls_emmet.setup { capabilities = capabilities }

lspconfig.tsserver.setup {
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx"
    },
    on_attach = on_attach,
    capabilities = capabilities
}

local vs_code_extracted = {
    html = "vscode-html-language-server",
    cssls = "vscode-css-language-server",
    vimls = "vim-language-server"
}

for ls, cmd in pairs(vs_code_extracted) do
    lspconfig[ls].setup {
        cmd = {cmd, "--stdio"},
        on_attach = on_attach,
        capabilities = capabilities
    }
end

lspconfig.jsonls.setup {
    cmd = {"vscode-json-language-server", "--stdio"},
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {"json", "jsonc"},
}

