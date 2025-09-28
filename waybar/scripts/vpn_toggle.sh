#!/bin/bash

check_vpn_status() {
    # Check VPN status using adguardvpn-cli status
    if adguardvpn-cli status | grep -q "Connected"; then
        echo "on"
    else
        echo "off"
    fi
}

if [ "$(check_vpn_status)" == "on" ]; then
    echo '{"text":"󰖂 ON","tooltip":"VPN Connected"}'
else
    echo '{"text":"󰖂 OFF","tooltip":"VPN Disconnected"}'
fi