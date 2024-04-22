# Path
set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $fish_user_paths

# Environement variables
set -gx QT_QPA_PLATFORMTHEME qt5ct
set -gx _JAVA_AWT_WM_NONREPARENTING 1
set -gx _JAVA_OPTIONS '-Dawt.useSystemAAFontSettings=gasp'

# Set default or vi keybindings
function fish_user_key_bindings
  # fish_default_key_bindings
  fish_vi_key_bindings
end

# Startup commands/message
if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_greeting "Hello cunt.."
end

# Set the cursor shapes for the different vi modes.
set fish_cursor_default     block      blink
set fish_cursor_insert      line       blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual      block

# Autocomplete and syntax highlighting colors
set fish_color_normal "#f8f8f2"
set fish_color_command "#8be9fd"
set fish_color_autosuggestion "#6272a4"
set fish_color_error "#ff5555"
set fish_color_param "#bd93f9"

# Functions needed for !! and !$
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]; commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

# The bindings for !! and !$
if [ $fish_key_bindings = "fish_vi_key_bindings" ];
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

# Function for yazi cwd on (normal) quit
function yy
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

# Alises
alias lf="lfcd"
