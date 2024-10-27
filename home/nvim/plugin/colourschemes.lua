local handle = io.popen("yq 'if .palette then .palette else . end' ~/colors.yaml")
local result = handle:read("*a")
handle:close()
local table = vim.json.decode(result)
local new = {}
for key, value in pairs(table) do
	new[key] = "#" .. value
end
require("base16-colorscheme").setup(new)

local colors = require("base16-colorscheme").colors

vim.cmd("hi LineNr guibg=" .. colors.base00 .. " guifg=" .. colors.base02)
vim.cmd("hi EndOfBuffer guibg=" .. colors.base00 .. " guifg=" .. colors.base00)
