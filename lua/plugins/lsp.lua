return {
    {
        "VonHeikemen/lsp-zero.nvim",
        dependencies = {
            "hrsh7th/nvim-cmp",
            "ray-x/lsp_signature.nvim",
            "simrat39/rust-tools.nvim",
        },
        cmd = { "LspInfo", "LspInstall", "LspStart", "Mason" },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lsp = require("lsp-zero").preset({})

            lsp.on_attach(function(client, buffer)
                require("lsp_signature").on_attach({}, buffer)

                lsp.default_keymaps({ preserve_mappings = false })

                local function map(lhs, rhs, opts)
                    opts = opts or {}
                    opts.buffer = true
                    vim.keymap.set("n", lhs, rhs, opts)
                end

                map("<Leader>la", vim.lsp.buf.code_action, { desc = "Code action" })
                map("<Leader>lf", vim.lsp.buf.format, { desc = "Format document" })
                map("<Leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
                map("<Leader>ls", "<CMD>Telescope lsp_document_symbols<CR>", { desc = "Document symbols" })
                map("<Leader>lS", "<CMD>Telescope lsp_workspace_symbols<CR>", { desc = "Workspace symbols" })
                map("<Leader>ld", "<CMD>Telescope diagnostics<CR>", { desc = "Diagnostics" })
                map("gd", "<CMD>Telescope lsp_definitions<CR>", { desc = "Definitions" })
                map("gi", "<CMD>Telescope lsp_implementations<CR>", { desc = "Implementations" })
                map("go", "<CMD>Telescope lsp_type_definitions<CR>", { desc = "Type definitions" })
                map("gr", "<CMD>Telescope lsp_references<CR>", { desc = "References" })
                map("gh", vim.diagnostic.open_float, { desc = "Show diagnostic" })

                if client.name == "rust_analyzer" then
                    map("<Leader>lR", "<CMD>RustRunnables<CR>", { desc = "Rust Runnables" })
                    map("<Leader>xR", "<CMD>RustDebuggables<CR>", { desc = "Rust Debuggables" })
                end
            end)

            lsp.extend_cmp()

            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "ruff_lsp",
                    "rust_analyzer",
                    "lua_ls",
                    "html",
                    "cssls",
                    "tsserver",
                },
                handlers = {
                    lsp.default_setup,
                    lua_ls = function()
                        require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
                    end,
                    rust_analyzer = function()
                        local mason_registry = require("mason-registry")

                        local codelldb = mason_registry.get_package("codelldb")
                        local extension_path = codelldb:get_install_path() .. "/extension/"
                        local codelldb_path = extension_path .. "adapter/codelldb"
                        local liblldb_path =
                            vim.fn.has("mac") == 1 and extension_path .. "lldb/lib/liblldb.dylib"
                            or extension_path .. "lldb/lib/liblldb.so"
                        local adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)

                        require("rust-tools").setup({
                            dap = { adapter = adapter }
                        })
                    end,
                }
            })
        end
    },
}
