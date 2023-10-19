return {{
    "NeogitOrg/neogit",
    dependencies = {"nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", "sindrets/diffview.nvim"},
    cmd = "Neogit",
    keys = {{
        "<Leader>g",
        "<cmd>Neogit<cr>",
        desc = "Neogit"
    }},
    opts = {}
},
{
    "nvim-neorg/neorg",
    dependencies = { "nvim-lua/plenary.nvim" },
    build = ":Neorg sync-parsers",
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {}, -- icons
        ["core.dirman"] = { -- workspace management
          config = {
            workspaces = {
              notes = "~/Notes",
            },
          },
        },
        ["core.export"] = {}, -- export to markdown
      },
    },}
}