return {
    {
        "f-person/git-blame.nvim",
        config = function()
            require('gitblame').setup()
        end,
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional - Diff integration
            "nvim-telescope/telescope.nvim", -- optional
        },
        config = true,
        config = function()
            local neogit = require('neogit')
            neogit.setup({})
            vim.keymap.set('n', '<leader>gN', "<cmd>Neogit<cr>", {})
        end,
    }
}
