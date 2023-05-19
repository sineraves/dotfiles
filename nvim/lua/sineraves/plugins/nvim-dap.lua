local ok, dap = pcall(require, "dap")
if not ok then
  return
end

-- Ruby debugger
-- Starting point: https://github.com/suketa/nvim-dap-ruby
dap.adapters.ruby = function(callback, config)
  local handle
  local stdout = vim.loop.new_pipe(false)
  local pid_or_err
  local waiting = config.waiting or 500
  local args
  local script
  local rdbg

  if config.current_line then
    script = config.script .. ":" .. vim.fn.line(".")
  else
    script = config.script
  end

  if config.bundle == "bundle" then
    args = { "-n", "--open", "--port", config.port, "-c", "--", "bundle", "exec", config.command, script }
  else
    args = { "--open", "--port", config.port, "-c", "--", config.command, script }
  end

  local opts = {
    stdio = { nil, stdout },
    args = args,
    detached = false,
  }

  if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
    rdbg = "rdbg.bat"
  else
    rdbg = "rdbg"
  end

  handle, pid_or_err = vim.loop.spawn(rdbg, opts, function(code)
    handle:close()
    if code ~= 0 then
      assert(handle, "rdbg exited with code: " .. tostring(code))
      print("rdbg exited with code", code)
    end
  end)

  assert(handle, "Error running rgdb: " .. tostring(pid_or_err))

  stdout:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      vim.schedule(function()
        require("dap.repl").append(chunk)
      end)
    end
  end)

  -- Wait for rdbg to start
  vim.defer_fn(function()
    callback({ type = "server", host = config.server, port = config.port })
  end, waiting)
end

dap.configurations.ruby = {
  {
    type = "ruby",
    name = "Debug RSpec file",
    bundle = "bundle",
    request = "attach",
    command = "rspec",
    script = "${file}",
    port = 38698,
    server = "127.0.0.1",
    options = {
      source_filetype = "ruby",
    },
    localfs = true,
    waiting = 1000,
  },
  {
    type = "ruby",
    name = "Debug RSpec test on current line",
    bundle = "bundle",
    request = "attach",
    command = "rspec",
    script = "${file}",
    port = 38698,
    server = "127.0.0.1",
    options = {
      source_filetype = "ruby",
    },
    localfs = true,
    waiting = 1000,
    current_line = true,
  },
  {
    type = "ruby",
    name = "Debug RSpec suite",
    bundle = "bundle",
    request = "attach",
    command = "rspec",
    script = "./spec",
    port = 38698,
    server = "127.0.0.1",
    options = {
      source_filetype = "ruby",
    },
    localfs = true,
    waiting = 1000,
  },
  {
    type = "ruby",
    name = "Debug current file",
    bundle = "",
    request = "attach",
    command = "ruby",
    script = "${file}",
    port = 38698,
    server = "127.0.0.1",
    options = {
      source_filetype = "ruby",
    },
    localfs = true,
    waiting = 1000,
  },
}
