#!/usr/bin/env bash

pkill waybar; pkill swaync
sleep 0.5

swaync &
waybar &
