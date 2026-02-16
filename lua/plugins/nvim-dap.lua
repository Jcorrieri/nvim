return {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        'williamboman/mason.nvim', -- Ensure Mason is loaded first
        "jay-babu/mason-nvim-dap.nvim",
        "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
        local mason_dap = require("mason-nvim-dap")
        local dap = require("dap")
        local ui = require("dapui")
        local dap_virtual_text = require("nvim-dap-virtual-text")

        -- Dap Virtual Text
        dap_virtual_text.setup()

        -- Configurations
        mason_dap.setup({
            ensure_installed = { "codelldb", "python" },
            automatic_installation = true,
            handlers = {
                function(config)
                    require("mason-nvim-dap").default_setup(config)
                end,
            },
        })

        dap.configurations.cpp = {
            {
                name = "Launch file",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
            },
        }
        dap.configurations.c = dap.configurations.cpp

        dap.configurations.python = {
            {
                type = 'python',
                request = 'launch',
                name = "Launch file (Conda)",
                program = "${file}",
                pythonPath = function()
                    -- 1. Check for a local conda env in the current directory
                    local cwd = vim.fn.getcwd()
                    if vim.fn.executable(cwd .. '/env/bin/python') == 1 then
                        return cwd .. '/env/bin/python'
                    end

                    -- 2. Fallback to the active Conda environment via shell variable
                    -- This works if you ran 'conda activate' before launching Neovim
                    local conda_prefix = os.getenv("CONDA_PREFIX")
                    if conda_prefix then
                        return conda_prefix .. '/bin/python'
                    end

                    -- 3. Final fallback to system python
                    return '/usr/bin/python3'
                end,
            },
            {
                type = 'python',
                request = 'launch',
                name = "Launch file with arguments (Conda)",
                program = "${file}",
                args = function()
                    local args_string = vim.fn.input('Arguments: ')
                    return vim.split(args_string, " +")
                end,
                pythonPath = function()
                    local cwd = vim.fn.getcwd()
                    if vim.fn.executable(cwd .. '/env/bin/python') == 1 then
                        return cwd .. '/env/bin/python'
                    end

                    local conda_prefix = os.getenv("CONDA_PREFIX")
                    if conda_prefix then
                        return conda_prefix .. '/bin/python'
                    end

                    return '/usr/bin/python3'
                end,
            },
        }

        -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
        dap.configurations.go = {
            {
                type = "delve",
                name = "Debug",
                request = "launch",
                program = "${file}"
            },
            {
                type = "delve",
                name = "Debug test", -- configuration for debugging test files
                request = "launch",
                mode = "test",
                program = "${file}"
            },
            -- works with go.mod packages and sub packages 
            {
                type = "delve",
                name = "Debug test (go.mod)",
                request = "launch",
                mode = "test",
                program = "./${relativeFileDirname}"
            } 
        }

        -- Dap UI

        ui.setup()

        vim.fn.sign_define("DapBreakpoint", { text = "🔴" })

        dap.listeners.before.attach.dapui_config = function()
            ui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            ui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            ui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            ui.close()
        end
    end,
}
