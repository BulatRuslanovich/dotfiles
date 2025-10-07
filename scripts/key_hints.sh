#!/usr/bin/env bash

if pidof yad > /dev/null; then
    pkill yad
fi

yad --center --title="Keybinding Hints" --no-buttons --list \
    --column=Key: --column="" --column=Description: \
    --timeout-indicator=bottom \
"  =   "          "        "  "SUPER KEY (Windows Key Button)" \
"" "" "" \
"  H"              "        "  "Show keybinding hints" \
"  T"              "        "  "Open terminal" \
"  E"              "        "  "Open file manager" \
"  B"              "        "  "Open browser" \
"" "" "" \
"  Q"              "        "  "Close active window" \
"  D"              "        "  "App launcher" \
"  L"              "        "  "Lock screen" \
"" "" "" \
"  F"              "        "  "Toggle floating" \
"  P"              "        "  "Toggle pseudo (dwindle)" \
"  J"              "        "  "Toggle split (dwindle)" \
"" "" "" \
"  C"              "        "  "Wifi menu" \
"  SHIFT H"        "        "  "Launch widgets" \
"  SHIFT W"        "        "  "Select wallpaper" \
"  W"              "        "  "Random wallpaper" \




"" "" "" \
"  [1 -> 0]"       "        "  "Switch workspace 1-10" \
"  Shift [1 -> 0]" "        "  "Move window to workspace 1-10" \
"" "" "" \
"More Keybinding"   "        "  "$HOME/.config/hypr/configs/keybinds.conf"