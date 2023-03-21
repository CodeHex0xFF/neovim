return {
	colorscheme = "catppuccin",
	plugins = {
		{
			"catppuccin/nvim",
			as = "catppuccin",
			config = function()
				require("catppuccin").setup({})
			end,
		},
	},
	options = {
		opt = {
			cmdheight = 1,
		},
	},
	lsp = {
		formatting = {
			format_on_save = {
				enabled = true,
				all_filetypes = {
					"lua",
					"python",
					"c",
					"cpp",
				},
			},
		},
		config = {
			clangd = {
				single_file_support = true,
				cmd = {
					"clangd",
					"--background-index",
					"--pch-storage=memory",
					"--query-driver=/usr/bin/clang++,/usr/bin/**/clang-*,/bin/clang,/bin/clang++,/usr/bin/gcc,/usr/bin/g++,/opt/petalinux/2019.2/sysroots/x86_64-petalinux-linux/usr/bin/arm-xilinx-linux-gnueabi/arm-xilinx-linux-gnueabi-g++,/opt/petalinux/2021.2/sysroots/x86_64-petalinux-linux/usr/bin/aarch64-xilinx-linux/aarch64-xilinx-linux-g++, /opt/petalinux/2019.2/sysroots/x86_64-petalinux-linux/usr/bin/arm-xilinx-linux-gnueabi/arm-xilinx-linux-gnueabi-gcc,/opt/petalinux/2022.2/sysroots/x86_64-petalinux-linux/usr/bin/aarch64-xilinx-linux/aarch64-xilinx-linux-gcc,/opt/petalinux/2022.2/sysroots/x86_64-petalinux-linux/usr/bin/aarch64-xilinx-linux/aarch64-xilinx-linux-g++",
					"--clang-tidy",
					"--all-scopes-completion",
					"--cross-file-rename",
					"--completion-style=detailed",
					"--header-insertion-decorators",
					"--header-insertion=iwyu",
				},
			},
		},
	},
}
