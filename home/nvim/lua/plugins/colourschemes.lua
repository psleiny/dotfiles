local function getValues(inputTable)
	local valuesTable = {}
	for _, value in pairs(inputTable) do
		table.insert(valuesTable, value)
	end
	return valuesTable
end

return {
	"RRethy/base16-nvim",
	{
		"rachartier/tiny-devicons-auto-colors.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		event = "VeryLazy",
		config = function()
			require("tiny-devicons-auto-colors").setup({
				colors = getValues(require("base16-colorscheme").colors),
			})
		end,
	},
}
