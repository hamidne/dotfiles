local M = {}

------------------------------------------------------------------------------------- Languages

M.languages = {
	'go',
	'javascript',
	'python',
	'lua',
	'bash',
	'json',
	'yaml',
}

------------------------------------------------------------------------------------- Capabilities

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true

------------------------------------------------------------------------------------- On Attach

local function lsp_keymaps(bufnr)
	local opts = { silent = true, buffer = bufnr }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

end

local function lsp_highlight_document(client)
	-- if client.server_capabilities.document_highlight then
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
	  return
	end
	illuminate.on_attach(client)
	-- end
end

local function attach_navic(client, bufnr)
	vim.g.navic_silence = true
	local status_ok, navic = pcall(require, "nvim-navic")
	if not status_ok then
	  return
	end
	navic.attach(client, bufnr)
end

M.on_attach = function(client, bufnr) 
	lsp_keymaps(bufnr)
	lsp_highlight_document(client)
	attach_navic(client, bufnr)
end

return M
