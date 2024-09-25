return {
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "vyfor/cord.nvim",
    build = "./build || .\\build",
    event = "VeryLazy",
    opts = {}, -- calls require('cord').setup()
  },
}
