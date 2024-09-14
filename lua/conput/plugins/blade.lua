return {
	"jwalton512/vim-blade",
	name = "vim-blade",
	priority = 1000,
	config = function()
		vim.g.blade_fold_enable = true
		vim.g.blade_fold_markers = {
			["if"] = "endif",
			["for"] = "endfor",
			["foreach"] = "endforeach",
			["while"] = "endwhile",
			["switch"] = "endswitch",
			["try"] = "endtry",
			["catch"] = "catch",
			["function"] = "endfunction",
			["class"] = "endclass",
		}
	end,
}
