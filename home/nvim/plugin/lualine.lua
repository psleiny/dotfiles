local custom = require("lualine.themes.base16")
local colors = require("base16-colorscheme").colors

custom.normal.c = { bg = colors.base00, fg = colors.base05 }
custom.insert.c = { bg = colors.base00, fg = colors.base05 }
custom.visual.c = { bg = colors.base00, fg = colors.base05 }
custom.replace.c = { bg = colors.base00, fg = colors.base05 }
custom.command.c = { bg = colors.base00, fg = colors.base05 }
custom.inactive.c = { bg = colors.base00, fg = colors.base05 }

require("lualine").setup({
	options = {
		theme = custom,
		component_separators = { left = "|", right = "|" },
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "buffers" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})
