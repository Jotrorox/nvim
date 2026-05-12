local modes = {
  n = "NORMAL",
  no = "OP",
  nov = "OP",
  noV = "OP",
  ["no\22"] = "OP",
  niI = "NORMAL",
  niR = "NORMAL",
  niV = "NORMAL",
  nt = "NORMAL",
  v = "VISUAL",
  vs = "VISUAL",
  V = "V-LINE",
  ["\22"] = "V-BLOCK",
  s = "SELECT",
  S = "S-LINE",
  ["\19"] = "S-BLOCK",
  i = "INSERT",
  ic = "INSERT",
  ix = "INSERT",
  R = "REPLACE",
  Rc = "REPLACE",
  Rx = "REPLACE",
  Rv = "V-REPLACE",
  Rvc = "V-REPLACE",
  Rvx = "V-REPLACE",
  c = "COMMAND",
  cv = "EX",
  r = "PROMPT",
  rm = "MORE",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  t = "TERMINAL",
}

local function hl(group, fg, bg, style)
  local opts = { fg = fg, bg = bg }
  if style then
    opts[style] = true
  end
  vim.api.nvim_set_hl(0, group, opts)
end

local function setup_highlights()
  hl("StatusLineMode", "#2e3440", "#88c0d0", "bold")
  hl("StatusLineFile", "#eceff4", "#3b4252")
  hl("StatusLineInfo", "#d8dee9", "#2e3440")
  hl("StatusLineWarn", "#ebcb8b", "#2e3440")
  hl("StatusLineError", "#bf616a", "#2e3440")
  hl("StatusLineOk", "#a3be8c", "#2e3440")
  hl("StatusLineDim", "#81a1c1", "#2e3440")
  hl("StatusLine", "#d8dee9", "#2e3440")
  hl("StatusLineNC", "#4c566a", "#2e3440")
end

local function diagnostics()
  local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  local parts = {}

  if errors > 0 then
    parts[#parts + 1] = "%#StatusLineError#E:" .. errors
  end

  if warnings > 0 then
    parts[#parts + 1] = "%#StatusLineWarn#W:" .. warnings
  end

  if #parts == 0 then
    return "%#StatusLineOk#OK"
  end

  return table.concat(parts, " ")
end

local function git_branch()
  local branch = vim.b.gitsigns_head
  if branch and branch ~= "" then
    return " " .. branch
  end
  return ""
end

function _G.UserStatusline()
  local mode = modes[vim.api.nvim_get_mode().mode] or "UNKNOWN"
  local file = vim.fn.expand("%:t")

  if file == "" then
    file = "[No Name]"
  end

  local modified = vim.bo.modified and " +" or ""
  local readonly = vim.bo.readonly and " RO" or ""
  local filetype = vim.bo.filetype ~= "" and vim.bo.filetype or "plain"

  return table.concat({
    "%#StatusLineMode# ",
    mode,
    " ",
    "%#StatusLineFile# ",
    file,
    modified,
    readonly,
    "%#StatusLineDim#",
    git_branch(),
    " %=",
    diagnostics(),
    "%#StatusLineInfo# ",
    filetype,
    " %l:%c ",
  })
end

setup_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("user-statusline", { clear = true }),
  callback = setup_highlights,
})

vim.opt.laststatus = 3
vim.opt.statusline = "%!v:lua.UserStatusline()"
