local exists, cmp = pcall(require, "cmp")
if not exists then
  return
end

cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      -- ['<Tab>'] = function(fallback)
      --   if cmp.visible() then
      --     cmp.select_next_item()
      --   else
      --     fallback()
      --   end
      -- end,

      -- ['<S-Tab>'] = function(fallback)
      --   if cmp.visible() then
      --     cmp.select_prev_item()
      --   else
      --     fallback()
      --   end
      -- end,
        
      ['<Esc>'] = cmp.mapping.close(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = {
      { name = 'nvim_lsp' }, -- For nvim-lsp
      { name = 'vsnip' }, -- For vsnip users.
      { name = 'buffer', keyword_length = 4 }, -- for buffer word completion
      { name = 'path' }, -- for path completion
      -- { name = 'omni' },
      -- { name = 'emoji', insert = true, } -- emoji completion
    },
    completion = {
      keyword_length = 1,
      completeopt = "menu,menuone,noselect"
    },
    -- view = {
    --   entries = 'custom',
    -- },
    -- formatting = {
    --   format = lspkind.cmp_format({
    --     mode = "symbol_text",
    --     menu = ({
    --       nvim_lsp = "[LSP]",
    --       ultisnips = "[US]",
    --       nvim_lua = "[Lua]",
    --       path = "[Path]",
    --       buffer = "[Buffer]",
    --       emoji = "[Emoji]",
    --         omni = "[Omni]",
    --     }),
    --   }),
    -- },
})
