return {
  "ThePrimeagen/refactoring.nvim",
  keys = {
    {
      "<leader>rc",
      function()
        require("refactoring").select_refactor()
      end,
      mode = "v",
      noremap = true,
      silent = true,
      expr = false,
    },
  },
  opts = {},
}
