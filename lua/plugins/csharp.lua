return {
    {
        "iabdelkareem/csharp.nvim",
        dependencies = {
            "williamboman/mason.nvim", -- Required, automatically installs omnisharp
            "mfussenegger/nvim-dap",
            "Tastyep/structlog.nvim", -- Optional, but highly recommended for debugging
        },
    }
}
