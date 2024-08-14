return {
    {
        "folke/which-key.nvim",
		priority = 999, 
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {

        },
    }
}
