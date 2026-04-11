local u = require "utils"

-- Leader key
u.map("nv", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable keys
u.map("nvit", "<Left>", "<Nop>", u.opts "Left is disabled")
u.map("nvit", "<Down>", "<Nop>", u.opts "Down is disabled")
u.map("nvit", "<Up>", "<Nop>", u.opts "Up is disabled")
u.map("nvit", "<Right>", "<Nop>", u.opts "Right is disabled")
u.map("nvit", "<F1>", "<Nop>", u.opts "F1 is disabled")
u.map("nvit", "<A-x>", "<Nop>", u.opts "Alt-x is disabled")
u.map("nvit", "<A-s>", "<Nop>", u.opts "Alt-s is disabled")
u.map("nvt", "q:", "<Nop>", u.opts "Disable q:")
u.map("nvt", "q/", "<Nop>", u.opts "Disable q/")
u.map("nvt", "q?", "<Nop>", u.opts "Disable q?")

-- Move in insert mode
u.map("i", "<C-h>", "<Left>", u.opts "Move left")
u.map("i", "<C-l>", "<Right>", u.opts "Move right")
u.map("i", "<C-j>", "<Down>", u.opts "Move down")
u.map("i", "<C-k>", "<Up>", u.opts "Move up")

-- Move selection
u.map("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
u.map("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
u.map("v", ">", ">gv", u.opts "Shift right")
u.map("v", "<", "<gv", u.opts "Shift left")

-- Delete without copy
u.map("nv", "x", '"_x', u.opts "Delete without copy")
u.map("nv", "X", '"_X', u.opts "Delete without copy")
u.map("nv", "d", '"_d', u.opts "Delete without copy")
u.map("nv", "D", '"_D', u.opts "Delete without copy")

-- Change without copy
u.map("nv", "c", '"_c', u.opts "Change without copy")
u.map("n", "C", '"_C', u.opts "Change without copy")

-- Cut
u.map("nv", "m", "d", u.opts "Cut")
u.map("nv", "M", "D", u.opts "Cut")

-- Paste
u.map("v", "p", '"_dP', u.opts "Keep last yanked on paste")
u.map("n", "p", function()
	vim.cmd "normal! p"
	vim.cmd "%s/\\r//e"
end, u.opts "Paste and remove \r")

-- Save
u.map("n", "<C-s>", function()
	if vim.fn.exists ":Format" == 2 then
		vim.cmd "Format"
	end
	vim.cmd "write"
end, { desc = "Save file" })

-- Format
u.map("n", "<C-f>", ":Format <CR>", u.opts "Format")

-- Quit
u.map("ni", "<C-q>", ":q <CR>", u.opts "Quit file")
u.map("ni", "<C-Q>", ":q! <CR>", u.opts "Quit without saving")

-- Move in insert mode
u.map("i", "<C-e>", "<End>", u.opts "Move end of line")
u.map("i", "<C-b>", "<Home>", u.opts "Move beginning of line")

-- Center on motion
u.map("n", "<C-d>", "<C-d>zz", u.opts "Center down")
u.map("n", "<C-u>", "<C-u>zz", u.opts "Center up")
u.map("n", "n", "nzzzv", u.opts "Center next search")
u.map("n", "N", "Nzzzv", u.opts "Center previous search")

-- Buffers
u.map("n", "<Tab>", ":bnext<CR>", u.opts "Next buffer")
u.map("n", "<S-Tab>", ":bprevious<CR>", u.opts "Previous buffer")
u.map("n", "<leader>x", ":bdelete!<CR>", u.opts "Close buffer")
u.map("n", "<leader>b", ":new <CR>", u.opts "New buffer")

-- Splits
u.map("n", "<leader>\\", "<C-w>v", u.opts "Split window vertically")
u.map("n", "<leader>-", "<C-w>s", u.opts "Split window horizontally")
u.map("n", "<leader>se", "<C-w>=", u.opts "Equalize windows")
u.map("n", "<leader>xs", ":close<CR>", u.opts "Close current window")
u.map("n", "<C-h>", ":wincmd h<CR>", u.opts "Focus left split")
u.map("n", "<C-j>", ":wincmd j<CR>", u.opts "Focus lower split")
u.map("n", "<C-k>", ":wincmd k<CR>", u.opts "Focus upper split")
u.map("n", "<C-l>", ":wincmd l<CR>", u.opts "Focus right split")

-- Tabs
-- u.map("n", "<leader>to", ":tabnew<CR>", u.opts("New tab"))
-- u.map("n", "<leader>tx", ":tabclose<CR>", u.opts("Close tab"))
-- u.map("n", "<leader>tn", ":tabn<CR>", u.opts("Next tab"))
-- u.map("n", "<leader>tp", ":tabp<CR>", u.opts("Previous tab"))

-- Line wrapping
u.map("n", "<leader>lw", "<cmd>set wrap!<CR>", u.opts "Toggle wrapping")
