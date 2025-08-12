import os
import glob
from os import path
from typing import List
import subprocess

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, ScratchPad, DropDown, Key, Match, Screen
from libqtile.lazy import lazy

# from settings.path import qtile_path
import colors


# Checks if the computer has a battery (is a laptop)
def has_battery():
    # Returns True if any battery device exists under /sys/class/power_supply/
    return bool(glob.glob("/sys/class/power_supply/BAT*"))


mod = "mod4" if has_battery() else "mod1"
terminal = "kitty --single-instance"
browser = "brave"
rofi = "rofi -show drun"
powermenu = os.path.expanduser("~") + "/.config/rofi/powermenu"
flameshot = "flameshot gui -c"

colors, backgroundColor, foregroundColor, workspaceColor, chordColor = colors.dracula()


keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key(
        [mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"
    ),  # Toggle between different layouts as defined below
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key(
        [mod],
        "t",
        lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window",
    ),
    # Launch applications
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "w", lazy.spawn(browser), desc="Launch browser"),
    Key([mod], "r", lazy.spawn(rofi), desc="Launch rofi"),
    Key([mod], "p", lazy.spawn(powermenu), desc="Launch powermenu"),
    Key([], "Print", lazy.spawn(flameshot), desc="Take Screenshot"),
    # Fn keys
    Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer sset Master 2%- unmute")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer sset Master 2%+ unmute")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set 10+")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 10-")),
    # Reload, Shutdown and Lock
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Restart Qtile"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key(
        [mod, "shift"], "x", lazy.spawn("betterlockscreen -l blur"), desc="Lock screen"
    ),
]

groups = []
group_names = ["1", "2", "3", "4", "5", "6", "7", "8"]
group_labels = ["󰈹", "", "󰚗", "", "", "", "", ""]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            label=group_labels[i],
            layout="monadtall",
        )
    )

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Mod + Number to move to that group",
            ),
            # TODO complete this
            # Key([mod, "control"], "l", lazy.window.togroup(), desc="Move focused window to next group"),
            # Key([mod, "control"], "h", lazy.window.togroup(), desc="Move focused window to previous group"),
            Key(
                [mod, "control"],
                i.name,
                lazy.window.togroup(i.name),
                lazy.group[i.name].toscreen(),
                desc="Move focused window to that group",
            ),
        ]
    )

keys.extend(
    [
        Key([mod], "g", lazy.layout.grow()),
    ]
)


# Layout theme and layouts
layout_theme = {
    "margin": 6,
    "border_width": 3,
    "border_focus": workspaceColor,
    "border_normal": chordColor,
}

layouts = [
    layout.MonadTall(**layout_theme),
    # layout.RatioTile(**layout_theme),
    layout.Max(**layout_theme),
]

groups.append(
    ScratchPad(
        "scratchpad",
        [
            DropDown(
                "term1", "kitty --class=scratch", width=0.8, height=0.8, x=0.1, y=0.1
            ),
            DropDown(
                "term2", "kitty --class=scratch", width=0.8, height=0.8, x=0.1, y=0.1
            ),
        ],
    )
)

keys.extend(
    [
        Key(
            [mod],
            "n",
            lazy.group["scratchpad"].dropdown_toggle("term1"),
            desc="Terminal scratchpad 1",
        ),
    ]
)

widget_defaults = dict(
    font="JetBrainsMono Nerd Font Mono",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

# Before battery
widgets = [
    # Workspaces
    widget.GroupBox(
        font="JetBrainsMono Nerd Font",
        fontsize=16,
        margin_y=2,
        margin_x=4,
        padding_y=6,
        padding_x=6,
        borderwidth=2,
        disable_drag=True,
        inactive=foregroundColor,
        active=foregroundColor,
        hide_unused=False,
        rounded=False,
        highlight_method="line",
        highlight_color=[backgroundColor, backgroundColor],
        this_current_screen_border=workspaceColor,
        urgent_alert_method="line",
        urgent_border=colors[9],
        urgent_text=colors[1],
        foreground=foregroundColor,
        background=backgroundColor,
        use_mouse_wheel=False,
    ),
    # Spacer to separate bar in two (left and right sides)
    widget.Spacer(),
    widget.Sep(padding=10, foreground=backgroundColor),
    # Updates available
    widget.TextBox(
        text="󰇚",
        fontsize=14,
        font="JetBrainsMono Nerd Font",
        foreground=workspaceColor,
    ),
    widget.CheckUpdates(
        update_interval=1800,
        distro="Arch_checkupdates",
        display_format=" {updates}",
        no_update_string="0",
    ),
    widget.TextBox(
        text=" Time:",
        fontsize=14,
        font="JetBrainsMono Nerd Font",
    ),
    widget.GenPollText(
        update_interval=1800,
        func=lambda: subprocess.check_output(
            os.path.expanduser("~") + "/.local/bin/time-since-update.sh"
        ).decode("utf-8"),
    ),
]

if has_battery():
    widgets.append(widget.Sep(padding=10, foreground=backgroundColor))

    # Battery level
    widgets.append(
        widget.TextBox(
            text="󰁹",
            fontsize=14,
            font="JetBrainsMono Nerd Font",
            foreground=workspaceColor,
        )
    )
    widgets.append(
        widget.Battery(
            format="{percent:1.0%}",
            full_char="",
            low_percentage=0.11,
            low_foreground=colors[9],
        )
    )

widgets.extend(
    [
        widget.Sep(padding=10, foreground=backgroundColor),
        # Volume level
        widget.TextBox(
            text="󰕾 ",
            fontsize=14,
            font="JetBrainsMono Nerd Font",
            foreground=workspaceColor,
        ),
        widget.Volume(fmt="{}"),
        widget.Sep(padding=10, foreground=backgroundColor),
        # Date and time
        widget.TextBox(
            text="󱑀 ",
            fontsize=14,
            font="JetBrainsMono Nerd Font",
            foreground=workspaceColor,
        ),
        widget.Clock(format="%A, %d %b %H:%M", font="JetBrainsMono Nerd Font"),
        # System tray
        widget.Systray(background=backgroundColor, icon_size=20, padding=4),
        widget.Sep(
            linewidth=0,
            padding=10,
            foreground=foregroundColor,
            background=backgroundColor,
        ),
    ]
)


screens = [
    Screen(
        top=bar.Bar(
            widgets,
            36,
            background=backgroundColor,
            margin=6,
        ),
        # Wallpaper
        wallpaper="~/Pictures/31.png",
        wallpaper_mode="fill",
        # Floating window drag
        x11_drag_polling_rate=165,
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(wm_class="blueman-manager"),  # blueman
        Match(wm_class="pavucontrol"),  # pavucontrol
        Match(wm_class="HardwareSimulatorMain"),
        Match(wm_class="CPUEmulatorMain"),
        Match(wm_class="VMEmulatorMain"),
        Match(wm_class="HackAssemblerMain"),
    ],
    border_width=3,
    border_focus=workspaceColor,
    border_normal=chordColor,
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True


# Autorstart commands
@hook.subscribe.startup_once
def autostart():
    script = os.path.expanduser("~") + "/.config/qtile/autostart"
    subprocess.Popen([script])


# Move config programs to config workspace
@hook.subscribe.client_new
def client_new(client):
    settings = ["Mullvad VPN", "Volume Control", "Bluetooth Devices"]
    if client.name in settings:
        client.togroup("8")


# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

wmname = "LG3D"
