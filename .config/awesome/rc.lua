-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")

-- Widget library
require("vicious")

require("revelation")
-- require("eminent")
-- require("shifty")
local scratch = require("scratch")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.add_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions

-- Themes define colours, icons, and wallpapers
beautiful.init(awful.util.getdir("config") .. "/themes/n4k0master/theme.lua")

-- This is used later as the default terminal and editor to run.
--terminal = "xterm"
terminal = "urxvt"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- TODO Seems Gentoo's problem.
dmenu = "/home/n4k0master/Scripts/" .. "dmenu_run -b -f -i -p 'Run command:' -nb '#1a1a1a' -nf '#cfcfcf' -sb '#696cae' -sf '#ffffff' -fn 'envy code R-9'"

screenshot_cmd = "scrot -e 'mv $f ~/Dropbox/Pictures/screenshots/ 2>/dev/null'"
screenlock_cmd = "xtrlock"
volume_up      = "amixer set Master 9%+"
volume_down    = "amixer set Master 9%-"
volume_toggle  = "amixer sset Master toggle"

-- transset_inc   = "transset-df --actual --inc 0.1"
-- transset_dec   = "transset-df --actual --dec 0.1"
-- Use ``transset-1.0.0'' instead of ``transset-df''
transset_inc   = "transset --actual --inc 0.1"
transset_dec   = "transset --actual --dec 0.1"


-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}

-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[2])
end
-- }}}

-- {{{ Menu

-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit },
   -- http://awesome.naquadah.org/wiki/ShutdownDialog
   -- { "Log out", '/home/n4k0master/Dropbox/Scripts/shutdown_dialog.sh'},
}

mysystemmenu = {
   { "terminal", terminal },
   { "emacs", "emacs" },
   { "pcmanfm", "pcmanfm" },
   { "ranger", terminal .. " -e ranger" },
   { "VirtualBox", "VirtualBox" },
   { "lock", "xtrlock" }
}

mybrowsermenu = {
   { "chromium", "chromium" },
   { "firefox", "Firefox" },
   { "luakit", "luakit" },
   { "uzbl", "uzbl" }
}

mygraphicmenu = {
   { "gimp", "gimp" },
   { "xmind", "xmind" },
   { "libreoffice", "libreoffice" }
}

mymainmenu = awful.menu({ items = {
                             { "awesome", myawesomemenu, beautiful.awesome_icon },
                             { "system-tools", mysystemmenu },
                             { "web-browsers", mybrowsermenu },
                             { "graphics", mygraphicmenu }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })

-- }}}

-- {{{ Wibox

-- https://github.com/Saint0fCloud/home/blob/master/.config/awesome/rc.lua
separator = widget({ type = "textbox" })
separator.text = "<span color='#ec3b89'>/</span>"
spacer = widget({ type = "textbox" })
spacer.text = "  "

-- Date and time
datewidget = widget({ type = "textbox", name = "datewidget" })
vicious.register(datewidget, vicious.widgets.date,
                 "%a, <span color='"..beautiful.fg_focus.."'>%b</span> %d <span color='"..beautiful.fg_urgent.."'>@%R</span>", 59)

-- -- Battery widget
-- batwidget = widget({ type = "textbox", name = "batwidget" })
-- vicious.register(batwidget, vicious.widgets.bat, 
-- 		 function (widget, args)
-- 		    if args[2] > 75 then
-- 		       return "<span color='" .. beautiful.fg_focus .. "'>Bat</span> " .. args[2]
-- 		    elseif args[2] < 7 then 
-- 		       naughty.notify({ title="Oh My God!", text="Critical Battery Level", font=beautiful.font, timeout=0, bg='#1C1C1C', fg='#7499C3', border_width=2, border_color="#EC0C52" }) 
-- 		       return "<span color='" .. beautiful.fg_urgent .. "'>Critical Bat</span> " .. args[2]
-- 		    elseif args[2] < 25 then
-- 		       return "<span color='" .. beautiful.fg_urgent .. "'>Low Bat</span> " .. args[2]
-- 		    else
-- 		       return "<span color='" .. beautiful.fg_focus .. "'>Bat</span> " .. args[2]
-- 		    end
-- 		 end, 183, 'BAT0')

-- volume
-- https://bbs.archlinux.org/viewtopic.php?pid=808350#p808350
volwidget = widget({ type = "textbox", name = "volwidget" })
vicious.register(volwidget, vicious.widgets.volume,
		 function (widget, args)
		    if args[1] == 0 or args[2] == "♩" then
		       return "Vol <span color='" .. beautiful.fg_urgent .. "'>MUTE</span>"
		    else
		       return "Vol <span color='" .. beautiful.fg_focus .. "'>" .. args[1] .. "%</span>"
		    end
		 end, 2, "Master" )

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", height = beautiful.menu_height, screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
       {
          mylauncher,
          mytaglist[s],
          mypromptbox[s],
          mylayoutbox[s],
          spacer, separator, spacer,
          layout = awful.widget.layout.horizontal.leftright
       },
       s == 1 and mysystray or nil,
       spacer, separator, spacer,
       datewidget,
       spacer, separator, spacer,
       -- batwidget,
       -- spacer, separator,
       volwidget,
       spacer,
       -- mytextclock,

       mytasklist[s],
       layout = awful.widget.layout.horizontal.rightleft
    }
end

-- }}}

-- {{{ Mouse bindings

root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

-- }}}

-- {{{ Key bindings

globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    -- Mac Os X like focus the window
    awful.key({ modkey,           }, "e", revelation),

    -- use <s-`> to open drop-down terminal (urxvt)
    awful.key({ modkey }, "`",
              function()
                 scratch.drop("urxvt", "center", "center", 0.5, 0.5)
              end),
    awful.key({ modkey }, "\\",
              function()
                 scratch.drop("emacs", "center", "center", 0.7, 0.7)
              end),


    -- circle focus
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey, "Shift"   }, "Tab",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "Down", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "Up",   function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "Down", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "Up",   function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    -- awful.key({ modkey,           }, "Tab",
    --     function ()
    --         awful.client.focus.history.previous()
    --         if client.focus then
    --             client.focus:raise()
    --         end
    --     end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "=",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "-",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "=",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "-",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "=",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "-",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- -- Menubar
    -- awful.key({ modkey }, "k", function() menubar.show() end),

    -- hide / show wibox (status bar)
    awful.key({ modkey }, "b",
              function ()
                 mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
              end),

    --dmenu
    awful.key({ modkey }, "p", function () awful.util.spawn(dmenu) end),

    awful.key({ }, "XF86AudioRaiseVolume", function () awful.util.spawn(volume_up) end),
    awful.key({ }, "XF86AudioLowerVolume", function () awful.util.spawn(volume_down) end),
    awful.key({ }, "XF86AudioMute", function () awful.util.spawn(volume_toggle) end),

    --screenshot
    awful.key({ }, "Print", function () awful.util.spawn(screenshot_cmd) end),
    --lockscreen(nil is needed)
    awful.key({ modkey, "Control" }, "l", nil, function () awful.util.spawn(screenlock_cmd) end),

    --transparency
    awful.key({ modkey }, "Next", function (c) awful.util.spawn_with_shell(transset_inc) end),
    awful.key({ modkey }, "Prior", function (c) awful.util.spawn_with_shell(transset_dec) end)

)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)

-- }}}

-- {{{ Rules

-- get class name $ xprop
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },

    { rule = { class = "feh" },
      properties = { floating = true } },

    -- media player
    { rule = { class = "MPlayer" },
      properties = { floating = true } },

    -- Flashplayer fullscreen
    { rule = { class = "Exe" },
      properties = { floating = true } },
    { rule = { class = "Operapluginwrapper-native" },
      properties = {
         floating = true,
      } },

    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },

    -- pdf
    { rule = { class = "Evince" },
      properties = { floating = true } },
    

    -- web-browsers
    { rule = { class = "Chromium" },
      properties = {
         -- tag = tags[1][1],
         -- border_width = 0,
         floating = true,
         maximized_vertical = true,
         maximized_horizontal = true
      } },

    { rule = { class = "opera" }, -- Use `Opera' will be wrong.
      properties = {
         -- tag = tags[1][1]
         -- border_width = 0,
         floating = true,
         maximized_vertical = true,
         maximized_horizontal = true
      } },

    { rule = { class = "luakit" },
      properties = {
         -- tag = tags[1][1]
      }
    },

    { rule = { class = "Firefox" },
      properties = {
         -- tag = tags[1][2]
         floating = true,
         maximized_vertical = true,
         maximized_horizontal = true
      } },

    { rule = { class = "VirtualBox" },
      properties = {
         floating = true,
      } },

    
    -- terminals
    { rule = { class = "URxvt" },
      properties = {
         size_hints_honor = false
      } },

    -- editors
    { rule = { class = "Emacs" },
      properties = {
         size_hints_honor = false
      } },
}

-- }}}

-- {{{ Signals

-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c)
                     c.border_color = beautiful.border_focus
                     -- c.opacity = 1
                           end)
client.add_signal("unfocus", function(c)
                     c.border_color = beautiful.border_normal
                     -- c.opacity = 0.7
                             end)

-- }}}
