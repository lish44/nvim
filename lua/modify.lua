
local function GetUpperCase(str)
	if not str:match('%a') then
		return 0
	elseif str == str:lower() then
		return 1
	elseif str == str:upper() then
		return 2
	elseif str:match('^%u%l*$') then
		return 3
	end
	return 0
end

local split = function()
	vim.cmd("set splitbelow")
	vim.cmd("sp")
	vim.cmd("res -5")
end

vim.g.flutter_default_device = 'macos'
vim.g.flutter_run_args = ''

function CompileRunGcc()
	vim.cmd("w")
	local ft = vim.bo.filetype
	if ft == "dart" then
		vim.cmd(":FlutterRun -d " .. vim.g.flutter_default_device .. " " .. vim.g.flutter_run_args)
	elseif ft == 'cs' then
		split()
		vim.cmd("!mcs %")
		vim.cmd("term mono %<.exe")
	elseif ft == 'python' then
		split()
		vim.cmd("term python3 %")
	elseif ft == 'markdown' or vim.bo.filetype == 'vimwiki' then
		vim.cmd("InstantMarkdownPreview")
	elseif ft == 'lua' then
		split()
		vim.cmd("term lua %")
	elseif ft == 'html' then
		vim.cmd("!\"" .. vim.g.mkdp_browser .. "\" % &")
	elseif ft == 'go' then
		split()
		vim.cmd("term go run %")
	elseif ft == 'sh' then
		split()
		vim.cmd("term bash %")
	end
end

function JumpToNextWord()
	vim.api.nvim_command('normal! w')
	while not vim.fn.strpart(vim.fn.getline('.'), vim.fn.col('.') - 1, 1):match('%w') do
		vim.api.nvim_command('normal! w')
	end
end

local function ToggleWord()
	local lis = {
		{ '!', '！' },
		{ ',', '，' },
		{ '.', '。' },
		{ '<^', 'LCtrl & ' },
		{ '>^', 'RCtrl & ' },
		{ 'from', 'to' },
		{ 'yes', 'no' },
		{ 'on', 'off' },
		{ 'down', 'up' },
		{ 'left', 'right' },
		{ 'top', 'bottom' },
		{ 'this', 'base' },
		{ 'read', 'write' },
		{ 'row', 'column' },
		{ 'rows', 'columns' },
		{ 'focus', 'blur' },
		{ 'lower', 'upper' },
		{ 'odd', 'even' },
		{ 'before', 'after' },
		{ 'max', 'min' },
		{ 'prev', 'next' },
		{ 'true', 'false' },
		{ 'enable', 'disable' },
		{ 'enabled', 'disabled' },
		{ 'user', 'pwd' },
		{ 'width', 'height' },
		{ 'horizontal', 'vertical' },
		{ 'username', 'password' },
		{ '左', '右' },
		{ '上', '下' },
		{ '水平', '垂直' },
		{ '1', '0' },
		{ '0', '1' },
		{ 'public', 'private' },
		{ 'private', 'public' },
		{ 'GameObject', 'TransForm' },
		{ 'TransForm', 'GameObject' },
	}
	local word = vim.fn.expand('<cword>')
	local idx0 = vim.fn.stridx(vim.fn.getline('.'), word, vim.fn.col('.') - #word)
	local strBefore = string.sub(vim.fn.getline('.'), 0, idx0)
	local strAfter = string.sub(vim.fn.getline('.'), idx0 + #word)
	local dic = {}
	for _, lPair in ipairs(lis) do
		dic[lPair[1]] = lPair[2]
		dic[lPair[2]] = lPair[1]
	end
	dic['int'] = 'integer'
	dic['integer'] = '^\\d+$'
	local upCase = GetUpperCase(word)
	local wordFixed = upCase > 0 and word:lower() or word
	if not dic[wordFixed] then
		if word:match('[A-Z]') then
			local char = ''
			local l = word:gsub('%u', char .. '%1'):split(char)
			for i, w in ipairs(l) do
				local upCase = GetUpperCase(w)
				local wordFixed = upCase > 0 and w:lower() or w
				if dic[wordFixed] then
					local res = dic[wordFixed]
					if upCase == 1 then
						res = res:lower()
					elseif upCase == 2 then
						res = res:upper()
					elseif upCase == 3 then
						res = res:sub(1, 1):lower() .. res:sub(2)
					end
					l[i] = res
					vim.fn.setline('.', table.concat(l, char))
					return
				end
			end
		end
		return
	end
	local res = dic[wordFixed]
	if upCase == 1 then
		res = res:lower()
	elseif upCase == 2 then
		res = res:upper()
	elseif upCase == 3 then
		res = res:sub(1, 1):lower() .. res:sub(2)
	end
	vim.api.nvim_put({ res }, "c", true, true)
end


function test()
    local lis = {
        { '!', '！' },
        -- Add other replacements here
    }
    local word = vim.fn.expand('<cword>')
    local idx0 = vim.fn.stridx(vim.fn.getline('.'), word, vim.fn.col('.') - #word)
    local idx1 = idx0 + #word
    local strBefore = string.sub(vim.fn.getline('.'), 1, idx0)
    local strAfter = string.sub(vim.fn.getline('.'), idx1 + 1)
    local dic = {}
    for _, lPair in ipairs(lis) do
        dic[lPair[1]] = lPair[2]
        dic[lPair[2]] = lPair[1]
    end
    -- Additional logic for handling case sensitivity omitted for brevity
    if dic[word] then
        local replacement = dic[word]
        vim.fn.setline('.', strBefore .. replacement .. strAfter)
    end
end

vim.api.nvim_set_keymap('n', 'W', ':lua JumpToNextWord()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<c-r>', ':lua CompileRunGcc()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'tt', ':lua test()<CR>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('x', '<A-t>', ':lua ToggleWord()<CR>', { noremap = true, silent = true })
