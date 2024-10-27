-- Thanks again, Stack Overflow!
local function readAll(file)
	local f = assert(io.open(file, "rb"))
	local content = f:read("*all")
	f:close()
	return content
end

local table = vim.json.decode(readAll(os.getenv("HOME") .. "/colors.json"))
local new = {}
for key, value in pairs(table) do
	new[key] = "#" .. value
end
require("base16-colorscheme").setup(new)

local colors = require("base16-colorscheme").colors

vim.cmd("hi LineNr guibg=" .. colors.base00 .. " guifg=" .. colors.base02)
vim.cmd("hi EndOfBuffer guibg=" .. colors.base00 .. " guifg=" .. colors.base00)
