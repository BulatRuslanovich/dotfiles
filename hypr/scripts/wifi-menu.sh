#!/usr/bin/fish

# Get a list of available wifi connections and morph it into a nice-looking list
set wifi_list (nmcli --fields "SECURITY,SSID" device wifi list | sed 1d | sed 's/  */ /g' | sed -E "s/WPA*.?\S/ /g" | sed "s/^--/ /g" | sed "s/  //g" | sed "/--/d")

set connected (nmcli -fields WIFI g)
if string match -q "*enabled*" "$connected"
    set toggle "󰖪  Disable Wi-Fi"
else if string match -q "*disabled*" "$connected"
    set toggle "󰖩  Enable Wi-Fi"
end

# Use rofi to select wifi network - передаем массив построчно
set chosen_network (begin
    echo $toggle
    for item in $wifi_list
        echo $item
    end
end | uniq -u | rofi -dmenu -i -selected-row 1 -p "Wi-Fi SSID: ")

# Get name of connection (remove first 3 characters - icon and spaces)
set chosen_id (string sub -s 4 "$chosen_network" | string trim)

if test -z "$chosen_network"
    exit
else if test "$chosen_network" = "󰖩  Enable Wi-Fi"
    nmcli radio wifi on
else if test "$chosen_network" = "󰖪  Disable Wi-Fi"
    nmcli radio wifi off
else
    # Message to show when connection is activated successfully
    set success_message "Connected to \"$chosen_id\""
    
    # Get saved connections
    set saved_connections (nmcli -g NAME connection)
    
    if contains -- "$chosen_id" $saved_connections
        nmcli connection up id "$chosen_id" | grep "successfully" && notify-send "Network" "$success_message" --icon ~/.config/eww/icons/wifi-solid.svg
    else
        if string match -q "**" "$chosen_network"
            set wifi_password (rofi -dmenu -config ~/.config/rofi/config-password.rasi -p "∂")
        end
        
        if test -n "$wifi_password"
            nmcli device wifi connect "$chosen_id" password "$wifi_password" | grep "successfully" && notify-send "Network" "$success_message" --icon ~/.config/eww/icons/wifi-solid.svg
        else
            nmcli device wifi connect "$chosen_id" | grep "successfully" && notify-send "Network" "$success_message" --icon ~/.config/eww/icons/wifi-solid.svg
        end
    end
end