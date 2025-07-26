local wezterm = require("wezterm")
local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha"
	else
		return "Catppuccin Latte"
	end
end

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
config.font = wezterm.font_with_fallback({
	"JetBrains Mono NL",
	"LXGW WenKai",
	"Noto Color Emoji",
})
config.window_padding = {
	left = "0cell",
	right = "0cell",
	top = "0cell",
	bottom = "0cell",
}
-- 当只有一个标签页时隐藏标签栏
config.hide_tab_bar_if_only_one_tab = true
-- 是否使用更精美的标签栏样式
config.use_fancy_tab_bar = false
-- 获取当前配色方案的颜色
config.window_background_opacity = 0.8
config.keys = {
	-- 使用Alt+n来新建标签页
	{
		key = "n",
		mods = "ALT",
		action = wezterm.action({
			SpawnTab = "DefaultDomain",
		}),
	},
	-- 使用Alt+j/k来切换标签页
	{
		key = "j",
		mods = "ALT",
		action = wezterm.action({
			ActivateTabRelative = -1,
		}),
	},
	{
		key = "k",
		mods = "ALT",
		action = wezterm.action({
			ActivateTabRelative = 1,
		}),
	},
	-- 使用Alt+w关闭标签页
	{
		key = "w",
		mods = "ALT",
		action = wezterm.action.CloseCurrentTab({ confirm = false }),
	},
	-- 使用CTRL+ALT+l 左右分屏
	{
		key = "l",
		mods = "ALT|CTRL",
		action = wezterm.action({
			SplitHorizontal = {
				domain = "CurrentPaneDomain",
			},
		}),
	},
	-- 使用CTRL+SHIFT+k 垂直分屏
	{
		key = "k",
		mods = "ALT|CTRL",
		action = wezterm.action({
			SplitVertical = {
				domain = "CurrentPaneDomain",
			},
		}),
	},
	-- 使用CTRL+w关闭分屏
	{
		key = "w",
		mods = "CTRL",
		action = wezterm.action.CloseCurrentPane({
			confirm = false,
		}),
	},
	-- 使用CTRL+ALT+h/j/k/l在分屏之间移动
	{
		key = "h",
		mods = "SHIFT|CTRL",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "SHIFT|CTRL",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "SHIFT|CTRL",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "SHIFT|CTRL",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
}

for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "ALT",
		action = wezterm.action.ActivateTab(i - 1),
	})
end
return config
