return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		scope = {
			enabled = false,
		},
		exclude = {
			filetypes = {
				"help",
				"startify",
				"dashboard",
				"packer",
				"neogitstatus",
				"NvimTree",
				"Trouble",
			},
		},
	},
}
