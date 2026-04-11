vim.g.have_nerd_font = true
vim.o.termguicolors = true
vim.o.clipboard = "unnamedplus"
vim.o.mouse = "a"
vim.opt.guicursor = "a:block"

vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.showtabline = 0
vim.o.showmode = false
vim.wo.signcolumn = "yes"

vim.o.wrap = false
vim.o.linebreak = true
vim.o.whichwrap = "bs<>[]hl"

vim.o.autoindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.breakindent = true

vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

vim.o.scrolloff = 4
vim.o.sidescrolloff = 8

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.undofile = true

vim.o.hlsearch = false
vim.o.incsearch = true

vim.o.pumheight = 10
vim.o.conceallevel = 0

vim.opt.fillchars = { fold = " " }
vim.opt.foldmethod = "indent"
vim.opt.foldenable = false
vim.opt.foldlevel = 99

vim.o.completeopt = "menuone"
vim.opt.shortmess:append "c"
vim.opt.iskeyword:append "-"
vim.opt.runtimepath:remove "/usr/share/vim/vimfiles"

vim.opt.list = true
vim.opt.listchars = { tab = "▏ ", trail = "·", nbsp = "␣" }
