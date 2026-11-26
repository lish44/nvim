local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local function collect_definition_locations(result)
	if not result then
		return {}
	end

	if result.uri or result.targetUri then
		result = { result }
	end

	local locations = {}

	for _, item in ipairs(result) do
		local uri = item.uri or item.targetUri
		local range = item.range or item.targetSelectionRange or item.targetRange
		if uri and range then
			table.insert(locations, { uri = uri, range = range })
		end
	end

	return locations
end

local function cursor_in_range(range)
	local cursor = vim.api.nvim_win_get_cursor(0)
	local line = cursor[1] - 1
	local col = cursor[2]
	local start_pos = range.start
	local end_pos = range["end"]

	if line < start_pos.line or line > end_pos.line then
		return false
	end

	if start_pos.line == end_pos.line then
		return col >= start_pos.character and col <= end_pos.character
	end

	if line == start_pos.line then
		return col >= start_pos.character
	end

	if line == end_pos.line then
		return col <= end_pos.character
	end

	return true
end

local function show_references()
	local has_telescope, telescope = pcall(require, "telescope.builtin")
	if has_telescope then
		telescope.lsp_references({
			include_declaration = false,
			initial_mode = "normal",
		})
		return
	end

	vim.lsp.buf.references()
end

local function show_implementations()
	local has_telescope, telescope = pcall(require, "telescope.builtin")
	if has_telescope then
		telescope.lsp_implementations({
			initial_mode = "normal",
		})
		return
	end

	vim.lsp.buf.implementation()
end

local function smart_gd()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	local position_encoding = clients[1] and clients[1].offset_encoding or "utf-16"
	local params = vim.lsp.util.make_position_params(0, position_encoding)
	local responses = vim.lsp.buf_request_sync(0, "textDocument/definition", params, 1000)

	if not responses or vim.tbl_isempty(responses) then
		vim.lsp.buf.definition()
		return
	end

	local current_uri = vim.uri_from_bufnr(0)
	local at_definition = false

	for _, response in pairs(responses) do
		for _, location in ipairs(collect_definition_locations(response.result)) do
			if location.uri == current_uri and cursor_in_range(location.range) then
				at_definition = true
				break
			end
		end

		if at_definition then
			break
		end
	end

	if at_definition then
		show_references()
		return
	end

	vim.lsp.buf.definition()
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		vim.keymap.set("n", "gd", smart_gd, { buffer = args.buf, desc = "LSP definition or references" })
		vim.keymap.set("n", "gi", show_implementations, { buffer = args.buf, desc = "LSP implementations" })
	end,
})

local servers = { "gopls" }

for _, server in ipairs(servers) do
	vim.lsp.config(server, {
		capabilities = capabilities,
		on_init = on_init,
	})
	vim.lsp.enable(server)
end

vim.lsp.config("jdtls", {
	cmd = {
		vim.fn.stdpath("data") .. "/mason/bin/jdtls",
		"--java-executable",
		"/opt/homebrew/opt/openjdk@21/bin/java",
	},
	capabilities = capabilities,
	on_init = on_init,
})
vim.lsp.enable("jdtls")
