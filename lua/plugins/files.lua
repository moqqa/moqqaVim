return {{
    "nvim-telescope/telescope.nvim",
    dependencies = {"debugloop/telescope-undo.nvim", "nvim-lua/plenary.nvim", {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = vim.fn.executable("make") ~= 0
    }, "nvim-telescope/telescope-ui-select.nvim", "axkirillov/easypick.nvim"},
    cmd = "Telescope",
    keys = {{
        "<Leader><Leader>",
        "<CMD>Telescope find_files<CR>",
        desc = "Find Files"
    }, {
        "<Leader>fb",
        "<CMD>Telescope buffers<CR>",
        desc = "Buffers"
    }, {
        "<Leader>fc",
        "<CMD>Easypick chezmoi<CR>",
        desc = "Chezmoi-managed files"
    }, {
        "<Leader>ff",
        "<CMD>Telescope find_files<CR>",
        desc = "Find Files"
    }, {
        "<Leader>fr",
        "<CMD>Telescope resume<CR>",
        desc = "Resume previous picker"
    }, {
        "<Leader>hH",
        "<CMD>Telescope highlights<CR>",
        desc = "Highlights"
    }, {
        "<Leader>hh",
        "<CMD>Telescope help_tags<CR>",
        desc = "Help tags"
    }, {
        "<Leader>hk",
        "<CMD>Telescope keymaps<CR>",
        desc = "Keymaps"
    }, {
        "<Leader>sg",
        "<CMD>Telescope live_grep<CR>",
        desc = "Live grep"
    }, {
        "<Leader>u",
        "<CMD>Telescope undo<CR>",
        desc = "File history"
    }},
    config = function()
        local ts = require("telescope")
        local layouts = require("telescope.pickers.layout_strategies")

        ts.setup({
            extensions = {
                ["ui-select"] = {require("telescope.themes").get_cursor()},
                undo = {
                    layout_strategy = "adaptive"
                }
            }
        })

        pcall(ts.load_extension, "fzf") -- native sorter
        ts.load_extension("ui-select") -- use telescope for code actions etc
        ts.load_extension("undo") -- undo tree

        require("easypick").setup({
            pickers = {{
                name = "chezmoi",
                command = "chezmoi managed --exclude encrypted --include files --path-style absolute",
                previewer = require("easypick").previewers.default()
            }}
        })
    end
}}
