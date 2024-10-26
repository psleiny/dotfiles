-- TODO: find a better solution that works with Stylix. This is ok I guess for now
require("base16-colorscheme").setup({
	base00 = "#161616",
	base01 = "#1E1E1E",
	base02 = "#393939",
	base03 = "#626262",
	base04 = "#8D8D8D",
	base05 = "#A8A8A8",
	base06 = "#E0E0E0",
	base07 = "#E6E6E6",
	base08 = "#AC6F6B",
	base09 = "#B78365",
	base0A = "#C0A479",
	base0B = "#8E9E6D",
	base0C = "#779E89",
	base0D = "#718FA0",
	base0E = "#928198",
	base0F = "#987A8C",
})

local colors = require("base16-colorscheme").colors

vim.cmd("hi LineNr guibg=" .. colors.base00 .. " guifg=" .. colors.base02)
vim.cmd("hi EndOfBuffer guibg=" .. colors.base00 .. " guifg=" .. colors.base00)
