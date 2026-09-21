
local opt = vim.opt
local api = vim.api

local options = {
	autocomplete = false,
	autoread = true,
	clipboard = "unnamedplus",
	conceallevel = 0, -- can create error on lazy installing plugins
	cursorline = true,
	expandtab = false,
	fileencoding = "utf-8",
	foldcolumn = "0",
	foldenable = true,
	foldexpr = 'v:lua.vim.lsp.foldexpr()',
	foldlevel = 99,
	foldtext = "",
	hlsearch = true,
	linebreak = true,
	list = true,
	listchars = "tab:-->,trail:~,space:·",
	mouse = "a",
	mousemodel = "popup_setpos",
	number = true,
	relativenumber = false,
	shiftwidth = 4,
	smartindent = true,
	splitbelow = true,
	splitright = true,
	tabstop = 4,
	termguicolors = true,
	textwidth = 125,
	winborder = "rounded",
}

for key,value in pairs(options) do
	opt[key] = value
end

vim.g.clipboard = "osc52"
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

opt.fillchars:append({ fold = " " } )
opt.formatoptions:append("cn")
opt.formatoptions:remove("ro")
opt.iskeyword:append("-")
opt.shortmess:append("c")
opt.statusline:append("%-{get(b:,'gitsigns_status','')}")
opt.whichwrap:append("<,>,[,],h,l")

-- Trim trailing whitespace on save
local opts = { clear = true }
local at_save = api.nvim_create_augroup("Save", opts)
api.nvim_create_autocmd({ "BufWrite" }, {
	pattern = { "*" },
	callback = function ()
		local cursor_pos = vim.api.nvim_win_get_cursor(0)

		-- Trim trailing whitespace
		if not vim.bo.modifiable then
			return
		end

		vim.cmd("%s/\\s\\+$//e")
		local filename = vim.api.nvim_buf_get_name(0)
		vim.cmd.save(filename)
		vim.api.nvim_win_set_cursor(0, cursor_pos)
	end,
	group = at_save,
})

opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap("", "<SPACE>", "<NOP>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "<leader>vs", "<CMD>split<CR>", opts)
keymap("n", "<leader>hs", "<CMD>vsplit<CR>", opts)

keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>wq", ":wq<CR>", opts)
keymap("n", "<leader>qq", ":q<CR>", opts)
keymap("n", "<leader>bw", ":w <bar> :Bdelete! %d <CR>", opts) -- buffer writing
keymap("n", "<leader>bd", ":bd<CR>", opts) -- buffer delete force
keymap("n", "<leader>bD", ":Bdelete!<CR>", opts) -- buffer delete force

keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Press jk fast to enter
keymap("i", "jj", "<ESC>:w<CR>", opts)
keymap("i", "jk", "<ESC>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Visual Block --
keymap("v", "p", function()
	local _, _, start_col = unpack(vim.fn.getpos('v'))
	local _, _, end_col = unpack(vim.fn.getpos('.'))
	local eol = vim.fn.col('$')

	local actual_end_col = math.max(start_col, end_col)

	if actual_end_col >= eol - 1 then
		return '"_dp'  -- at/near end of line, paste after
	else
		return '"_dP'  -- mid line, paste before
	end
end, { expr = true, noremap = true })

local function clear_multicursor()
	local ns = vim.api.nvim_create_namespace("nvim.multicursor")
	vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
end

keymap("n", "dmc", clear_multicursor, opts)

keymap("n", "<ESC>", "", opts)

keymap('n', "<leader>e", "<cmd>Lexplore<CR>", opts)

vim.cmd.packadd("nvim.undotree")

