-- my theme

theme = {}

themedir = awful.util.getdir("config") .. "/themes/n4k0master"

-- wallpaper
wallpaper1 = "cirno.png"
wallpaper2 = "touhou2.jpeg"
wallpaper3 = "touhou3.jpg"
wallpaper4 = "Vocaloid1.jpg"
wallpaper5 = "cirno2.jpeg"
wallpaper6 = "Ib1.jpg"
wallpaper7 = "sanae1.jpg"
theme.wallpaper_cmd = { "awsetbg -a " .. "/home/n4k0master/wallpapers/" .. wallpaper7 }

theme.font          = "Exo Medium 10.5"

theme.bg_normal     = "#373737"
theme.bg_focus      = "#3377aa"
theme.bg_urgent     = theme.bg_normal
theme.bg_minimize   = theme.bg_normal

theme.fg_normal     = "#998877"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffc200"
theme.fg_minimize   = "#bbbbbb"

theme.border_width  = 1
theme.border_normal = theme.bg_normal
theme.border_focus  = theme.fg_urgent
theme.border_marked = theme.border_focus

-- launcher menu
theme.menu_bg_nomal     = theme.bg_normal
theme.menu_border_color = theme.border_normal
theme.menu_height = "20"
theme.menu_width  = "150"

-- theme.useless_gap_width = "3"


-- Hint for "whether this frame in another tag"
theme.taglist_squares       = true
theme.taglist_squares_sel   = themedir .. "/taglist/squaref_b-red.png"
theme.taglist_squares_unsel = themedir .. "/taglist/squaref_b-blue.png"

-- tasklist
theme.tasklist_bg_focus = theme.bg_focus
theme.tasklist_floating_icon = "/usr/share/awesome/themes/default/tasklist/floatingw.png"


-- Layout icons
theme.layout_tile       = themedir .. "/layouts-huge/tile.png"
theme.layout_fairv      = themedir .. "/layouts-huge/fairv.png"
theme.layout_magnifier  = themedir .. "/layouts-huge/magnifier.png"
theme.layout_floating   = themedir .. "/layouts-huge/floating.png"

-- Menu Icons
-- theme.awesome_icon      = themedir .. "/logo/awesome-blue.png"
theme.awesome_icon      = "/usr/share/awesome/icons/awesome32.png"
theme.menu_submenu_icon = "/usr/share/awesome/themes/default/submenu.png"

return theme
