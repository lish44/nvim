return {
  {
    "ray-x/go.nvim",
    ft = { "go", "gomod" },
    cmd = { "GoHelp" },
    -- event = { "CmdlineEnter" },
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        run_in_floaterm = false,
        dap_debug = false,
        dap_debug_keymap = false,
        dap_debug_gui = false,
        dap_debug_vt = false,
      })

      local function stop_go_run(bufnr)
        local ok, term_win = pcall(vim.api.nvim_buf_get_var, bufnr, "go_float_terminal_win")
        if ok and term_win and term_win[1] and vim.api.nvim_buf_is_valid(term_win[1]) then
          local term_buf = term_win[1]
          local job_id = vim.b[term_buf].terminal_job_id
          if job_id then
            vim.api.nvim_chan_send(job_id, vim.api.nvim_replace_termcodes("<C-c>", true, false, true))
          end
          return
        end

        vim.cmd("GoStop")
      end

      local function close_go_run_split(bufnr)
        local ok, term_win = pcall(vim.api.nvim_buf_get_var, bufnr, "go_float_terminal_win")
        if not ok or not term_win then
          return
        end

        if term_win[1] and vim.api.nvim_buf_is_valid(term_win[1]) then
          pcall(vim.api.nvim_buf_delete, term_win[1], { force = true })
        end
        if term_win[2] and vim.api.nvim_win_is_valid(term_win[2]) then
          pcall(vim.api.nvim_win_close, term_win[2], true)
        end
      end

      local function stop_and_close_go_run(bufnr)
        stop_go_run(bufnr)
        vim.schedule(function()
          close_go_run_split(bufnr)
        end)
      end

      local function run_gorun_in_split()
        local go_term = require("go.term")
        local original_run = go_term.run

        go_term.run = function(opts)
          local source_buf = vim.api.nvim_get_current_buf()

          close_go_run_split(source_buf)

          vim.cmd("botright 12new")
          local term_buf = vim.api.nvim_get_current_buf()
          local term_win = vim.api.nvim_get_current_win()

          vim.fn.termopen(opts.cmd)
          vim.bo[term_buf].buflisted = false
          vim.api.nvim_buf_set_var(source_buf, "go_float_terminal_win", { term_buf, term_win })
          vim.keymap.set("n", "q", function()
            stop_and_close_go_run(source_buf)
          end, { buffer = term_buf, noremap = true, silent = true })
          vim.keymap.set("t", "q", function()
            stop_and_close_go_run(source_buf)
          end, { buffer = term_buf, noremap = true, silent = true })

          return term_buf, term_win
        end

        local ok, err = pcall(vim.cmd, "GoRun -F")
        go_term.run = original_run
        if not ok then
          error(err)
        end
      end

      vim.api.nvim_create_user_command("GoHelp", function()
        local lines = {
          "Go workflows",
          "",
          "Project / navigation",
          "  <leader>fp  Projects",
          "  <leader>e   Explorer toggle",
          "  <leader>fe  Reveal file in tree",
          "  <leader>o   Outline toggle",
          "",
          "Go build / test / run",
          "  <leader>gr  Go run",
          "  <leader>gs  Go stop",
          "  <leader>gb  Go build",
          "  <leader>gt  Go test",
          "  <leader>gT  Go test func",
          "  <leader>gn  Go test nearest",
          "  <leader>gc  Go coverage",
          "",
          "Go debug",
          "  <F5>        Start/Continue",
          "  <F6>        Step out",
          "  <F7>        Step into",
          "  <F8>        Step over",
          "  <F9>        Toggle breakpoint",
          "  <leader>dr  Debug current project",
          "  <leader>dc  Stop debug session",
          "  <leader>dd  Toggle breakpoint",
          "  <leader>db  Conditional breakpoint",
          "  <leader>gd  Debug nearest Go test",
          "  <leader>gD  Debug last Go test",
          "  <leader>dl  Toggle debug UI",
          "",
          "LSP",
          "  gh          Hover doc",
          "  <F1>        Code action",
          "  <F2>        Next diagnostic",
        }

        vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO, { title = "GoHelp" })
      end, {})

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "go", "gomod" },
        callback = function(args)
          local opts = { buffer = args.buf, noremap = true, silent = true }
          vim.keymap.set("n", "<leader>gr", function()
            run_gorun_in_split()
          end, vim.tbl_extend("force", opts, { desc = "Go run" }))
          vim.keymap.set("n", "<leader>gs", function()
            stop_go_run(args.buf)
          end, vim.tbl_extend("force", opts, { desc = "Go stop" }))
          vim.keymap.set("n", "<leader>gb", "<cmd>GoBuild<cr>", vim.tbl_extend("force", opts, { desc = "Go build" }))
          vim.keymap.set("n", "<leader>gt", "<cmd>GoTest<cr>", vim.tbl_extend("force", opts, { desc = "Go test" }))
          vim.keymap.set("n", "<leader>gT", "<cmd>GoTestFunc<cr>", vim.tbl_extend("force", opts, { desc = "Go test func" }))
          vim.keymap.set("n", "<leader>gc", "<cmd>GoCoverage<cr>", vim.tbl_extend("force", opts, { desc = "Go coverage" }))
          vim.keymap.set("n", "<leader>gn", "<cmd>GoTest -n<cr>", vim.tbl_extend("force", opts, { desc = "Go test nearest" }))
          vim.keymap.set("n", "<leader>gk", "<cmd>GoHelp<cr>", vim.tbl_extend("force", opts, { desc = "Go help" }))
        end,
      })
    end,
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
}
