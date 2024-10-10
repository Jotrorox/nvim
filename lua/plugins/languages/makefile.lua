return {
  {
    "Zeioth/makeit.nvim",
    cmd = {"MakeitOpen", "MakeitToggleResults", "MakeitRedo"},
    dependencies = { "stevearc/overseer.nvim" },
    opts = {},
  },
  {
    "stevearc/overseer.nvim",
    cmd = {"MakeitOpen", "MakeitToggleResults", "MakeitRedo"},
    opts = {
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1
      },
    },
  },
}
