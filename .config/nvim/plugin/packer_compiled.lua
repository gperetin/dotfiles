-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/goran/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/goran/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/goran/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/goran/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/goran/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["alpha-nvim"] = {
    config = { "\27LJ\2\n`\0\0\5\0\5\0\n6\0\0\0'\2\1\0B\0\2\0029\0\2\0006\2\0\0'\4\3\0B\2\2\0029\2\4\2B\0\2\1K\0\1\0\vconfig\26alpha.themes.startify\nsetup\nalpha\frequire\0" },
    loaded = true,
    path = "/home/goran/.local/share/nvim/site/pack/packer/start/alpha-nvim",
    url = "https://github.com/goolord/alpha-nvim"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/goran/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["gruvbox.nvim"] = {
    config = { "\27LJ\2\nÉ\1\0\0\3\0\t\0\0146\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0'\1\6\0=\1\5\0006\0\3\0009\0\a\0'\2\b\0B\0\2\1K\0\1\0\24colorscheme gruvbox\bcmd\tdark\15background\6o\bvim\nsetup\fgruvbox\frequire\0" },
    loaded = true,
    path = "/home/goran/.local/share/nvim/site/pack/packer/start/gruvbox.nvim",
    url = "https://github.com/ellisonleao/gruvbox.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\nÉ\5\0\0\5\0\31\0/6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\t\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0034\4\0\0=\4\b\3=\3\n\0025\3\f\0005\4\v\0=\4\r\0035\4\14\0=\4\15\0035\4\16\0=\4\17\0035\4\18\0=\4\19\0035\4\20\0=\4\21\0035\4\22\0=\4\23\3=\3\24\0025\3\25\0004\4\0\0=\4\r\0034\4\0\0=\4\15\0035\4\26\0=\4\17\0035\4\27\0=\4\19\0034\4\0\0=\4\21\0034\4\0\0=\4\23\3=\3\28\0024\3\0\0=\3\29\0024\3\0\0=\3\30\2B\0\2\1K\0\1\0\15extensions\ftabline\22inactive_sections\1\2\0\0\rlocation\1\2\0\0\rfilename\1\0\0\rsections\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\4\0\0\rencoding\15fileformat\rfiletype\14lualine_c\1\2\0\0\rfilename\14lualine_b\1\4\0\0\vbranch\tdiff\16diagnostics\14lualine_a\1\0\0\1\2\0\0\tmode\foptions\1\0\0\23disabled_filetypes\23section_separators\1\0\2\tleft\bÓÇ∞\nright\bÓÇ≤\25component_separators\1\0\2\tleft\bÓÇ±\nright\bÓÇ≥\1\0\4\25always_divide_middle\2\ntheme\tauto\18icons_enabled\2\17globalstatus\1\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "/home/goran/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\nR\0\1\3\1\2\0\f-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\21select_next_item\fvisibleR\0\1\3\1\2\0\f-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\21select_prev_item\fvisibleç\5\1\0\n\0'\0T6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\29\0005\4\6\0009\5\3\0009\a\3\0009\a\4\a)\t¸ˇB\a\2\0025\b\5\0B\5\3\2=\5\a\0049\5\3\0009\a\3\0009\a\4\a)\t\4\0B\a\2\0025\b\b\0B\5\3\2=\5\t\0049\5\3\0009\a\3\0009\a\n\aB\a\1\0025\b\v\0B\5\3\2=\5\f\0049\5\r\0009\5\14\5=\5\15\0049\5\3\0005\a\17\0009\b\3\0009\b\16\bB\b\1\2=\b\18\a9\b\3\0009\b\19\bB\b\1\2=\b\20\aB\5\2\2=\5\21\0043\5\22\0=\5\23\0043\5\24\0=\5\25\0049\5\3\0009\5\26\0055\a\27\0B\5\2\2=\5\28\4=\4\3\0039\4\r\0009\4\30\0044\6\3\0005\a\31\0>\a\1\0065\a \0>\a\2\0064\a\3\0005\b!\0>\b\1\aB\4\3\2=\4\30\3B\1\2\0019\1\2\0009\1\"\1'\3#\0005\4&\0009\5\r\0009\5\30\0054\a\3\0005\b$\0>\b\1\a4\b\3\0005\t%\0>\t\1\bB\5\3\2=\5\30\4B\1\3\0012\0\0ÄK\0\1\0\1\0\0\1\0\2\19keyword_length\3\3\tname\fcmdline\1\0\1\tname\tpath\6:\fcmdline\1\0\2\19keyword_length\3\4\tname\vbuffer\1\0\1\tname\tpath\1\0\1\tname\rnvim_lsp\fsources\1\0\0\t<CR>\1\0\1\vselect\1\fconfirm\f<S-Tab>\0\n<Tab>\0\n<C-e>\6c\nclose\6i\1\0\0\nabort\n<C-y>\fdisable\vconfig\n<C-c>\1\3\0\0\6i\6c\rcomplete\n<C-f>\1\3\0\0\6i\6c\n<C-b>\1\0\0\1\3\0\0\6i\6c\16scroll_docs\fmapping\nsetup\bcmp\frequire\0" },
    loaded = true,
    path = "/home/goran/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\nˇ\1\0\0\4\0\14\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0006\2\3\0009\2\4\0029\2\5\0029\2\6\2B\2\1\0A\0\0\0026\1\0\0'\3\a\0B\1\2\0029\1\b\0019\1\t\0015\3\n\0=\0\v\3B\1\2\0016\1\0\0'\3\a\0B\1\2\0029\1\f\0019\1\t\0015\3\r\0=\0\v\3B\1\2\1K\0\1\0\1\0\0\18rust_analyzer\17capabilities\1\0\0\nsetup\fpyright\14lspconfig\29make_client_capabilities\rprotocol\blsp\bvim\24update_capabilities\17cmp_nvim_lsp\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/goran/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\nÅ\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\ffilters\1\0\0\vcustom\1\0\0\1\4\0\0\n.git$\18node_modules$\r^target$\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/home/goran/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\22nvim-web-devicons\frequire\0" },
    loaded = true,
    path = "/home/goran/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/goran/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/goran/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\nÉ\5\0\0\5\0\31\0/6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\t\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0034\4\0\0=\4\b\3=\3\n\0025\3\f\0005\4\v\0=\4\r\0035\4\14\0=\4\15\0035\4\16\0=\4\17\0035\4\18\0=\4\19\0035\4\20\0=\4\21\0035\4\22\0=\4\23\3=\3\24\0025\3\25\0004\4\0\0=\4\r\0034\4\0\0=\4\15\0035\4\26\0=\4\17\0035\4\27\0=\4\19\0034\4\0\0=\4\21\0034\4\0\0=\4\23\3=\3\28\0024\3\0\0=\3\29\0024\3\0\0=\3\30\2B\0\2\1K\0\1\0\15extensions\ftabline\22inactive_sections\1\2\0\0\rlocation\1\2\0\0\rfilename\1\0\0\rsections\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\4\0\0\rencoding\15fileformat\rfiletype\14lualine_c\1\2\0\0\rfilename\14lualine_b\1\4\0\0\vbranch\tdiff\16diagnostics\14lualine_a\1\0\0\1\2\0\0\tmode\foptions\1\0\0\23disabled_filetypes\23section_separators\1\0\2\tleft\bÓÇ∞\nright\bÓÇ≤\25component_separators\1\0\2\tleft\bÓÇ±\nright\bÓÇ≥\1\0\4\25always_divide_middle\2\ntheme\tauto\18icons_enabled\2\17globalstatus\1\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: alpha-nvim
time([[Config for alpha-nvim]], true)
try_loadstring("\27LJ\2\n`\0\0\5\0\5\0\n6\0\0\0'\2\1\0B\0\2\0029\0\2\0006\2\0\0'\4\3\0B\2\2\0029\2\4\2B\0\2\1K\0\1\0\vconfig\26alpha.themes.startify\nsetup\nalpha\frequire\0", "config", "alpha-nvim")
time([[Config for alpha-nvim]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\22nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
time([[Config for nvim-web-devicons]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\nR\0\1\3\1\2\0\f-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\21select_next_item\fvisibleR\0\1\3\1\2\0\f-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\21select_prev_item\fvisibleç\5\1\0\n\0'\0T6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\29\0005\4\6\0009\5\3\0009\a\3\0009\a\4\a)\t¸ˇB\a\2\0025\b\5\0B\5\3\2=\5\a\0049\5\3\0009\a\3\0009\a\4\a)\t\4\0B\a\2\0025\b\b\0B\5\3\2=\5\t\0049\5\3\0009\a\3\0009\a\n\aB\a\1\0025\b\v\0B\5\3\2=\5\f\0049\5\r\0009\5\14\5=\5\15\0049\5\3\0005\a\17\0009\b\3\0009\b\16\bB\b\1\2=\b\18\a9\b\3\0009\b\19\bB\b\1\2=\b\20\aB\5\2\2=\5\21\0043\5\22\0=\5\23\0043\5\24\0=\5\25\0049\5\3\0009\5\26\0055\a\27\0B\5\2\2=\5\28\4=\4\3\0039\4\r\0009\4\30\0044\6\3\0005\a\31\0>\a\1\0065\a \0>\a\2\0064\a\3\0005\b!\0>\b\1\aB\4\3\2=\4\30\3B\1\2\0019\1\2\0009\1\"\1'\3#\0005\4&\0009\5\r\0009\5\30\0054\a\3\0005\b$\0>\b\1\a4\b\3\0005\t%\0>\t\1\bB\5\3\2=\5\30\4B\1\3\0012\0\0ÄK\0\1\0\1\0\0\1\0\2\19keyword_length\3\3\tname\fcmdline\1\0\1\tname\tpath\6:\fcmdline\1\0\2\19keyword_length\3\4\tname\vbuffer\1\0\1\tname\tpath\1\0\1\tname\rnvim_lsp\fsources\1\0\0\t<CR>\1\0\1\vselect\1\fconfirm\f<S-Tab>\0\n<Tab>\0\n<C-e>\6c\nclose\6i\1\0\0\nabort\n<C-y>\fdisable\vconfig\n<C-c>\1\3\0\0\6i\6c\rcomplete\n<C-f>\1\3\0\0\6i\6c\n<C-b>\1\0\0\1\3\0\0\6i\6c\16scroll_docs\fmapping\nsetup\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: gruvbox.nvim
time([[Config for gruvbox.nvim]], true)
try_loadstring("\27LJ\2\nÉ\1\0\0\3\0\t\0\0146\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0'\1\6\0=\1\5\0006\0\3\0009\0\a\0'\2\b\0B\0\2\1K\0\1\0\24colorscheme gruvbox\bcmd\tdark\15background\6o\bvim\nsetup\fgruvbox\frequire\0", "config", "gruvbox.nvim")
time([[Config for gruvbox.nvim]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\nÅ\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\ffilters\1\0\0\vcustom\1\0\0\1\4\0\0\n.git$\18node_modules$\r^target$\nsetup\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufRead * ++once lua require("packer.load")({'nvim-lspconfig'}, { event = "BufRead *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
