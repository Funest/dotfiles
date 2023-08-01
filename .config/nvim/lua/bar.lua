local M = {}

local triangles = {
    leftsolid = '',
    rightsolid = '',
    rightinsolid = '',
    leftinsolid = ''
}

-- Mode string:
local modes_dict = {
    ["n"] = "NORMAL",
    ["no"] = "NORMAL",
    ["v"] = "VISUAL",
    ["V"] = "VISUAL LINE",
    [""] = "VISUAL BLOCK",
    ["s"] = "SELECT",
    ["S"] = "SELECT LINE",
    [""] = "SELECT BLOCK",
    ["i"] = "INSERT",
    ["ic"] = "INSERT",
    ["R"] = "REPLACE",
    ["Rv"] = "VISUAL REPLACE",
    ["c"] = "COMMAND",
    ["cv"] = "VIM EX",
    ["ce"] = "EX",
    ["r"] = "PROMPT",
    ["rm"] = "MOAR",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERMINAL",
}

local function mode()
    return string.format(" %s ", modes_dict[vim.api.nvim_get_mode().mode], triangles.rightsolid)
end

local function modified_status()
    local readonlystatus = ""
    local modifiedstatus = "" 
    if vim.o.readonly then
        readonlystatus = "READONLY"
    end
    if vim.o.modified then
        modifiedstatus = "MODIFIED"
        readonlystatus = (readonlystatus ~= "" and {readonlystatus .. ", "} or {""})[1]
    end
    return string.format("%s%s", readonlystatus, modifiedstatus)
end



local function setup()
    -- Colors
    local colorsstring = [[
        hi ModeBlock        ctermfg=00  ctermbg=01
        hi ModeBlockEnd     ctermfg=01  ctermbg=05
        hi FileTypeBlock    ctermfg=00  ctermbg=05
        hi FileTypeBlockEnd ctermbg=05  cterm=reverse
        hi FileBlock        cterm=reverse   gui=reverse
        hi FileBlockEnd     ctermbg=00
        hi SecondaryBlock   ctermfg=07  ctermbg=00
        hi Blanks           ctermfg=07  ctermbg=00
        hi EndBlock         cterm=reverse   gui=reverse
    ]]
    vim.api.nvim_exec(colorsstring, false)

    -- Autocommand
    local refreshevents = "WinEnter,BufEnter,SessionLoadPost,FileChangedShellPost,VimResized,Filetype,CursorMoved,CursorMovedI,ModeChanged"
    vim.api.nvim_exec(string.format("autocmd %s * call v:lua.require('bar').refresh()", refreshevents), false)
end


local function refresh()
    -- Statusline definition
    local statusLine = {
        '%#ModeBlock#',
        mode(),
        '%#ModeBlockEnd#',
        triangles.rightsolid,
        '%#FileTypeBlock#',
        ' %{&filetype==""?"?":&filetype} ',
        '%#FileTypeBlockEnd#',
        triangles.rightsolid,
        '%#FileBlock#',
        ' %f ',
        '%#FileBlockEnd#',
        triangles.rightsolid,
        '%#Blanks#',
        '%=',
        modified_status(),
        '%=',
        '%#FileBlockEnd#',
        triangles.leftsolid,
        '%#FileBlock#',
        ' %P %l,%c ',
    }
    vim.o.statusline = table.concat(statusLine)
end

M.refresh = refresh
M.setup = setup
return M
