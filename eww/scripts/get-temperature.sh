#!/bin/bash

cpu_temp=$(sensors | awk '/^Core 0/ {print $3}' | tr -d '+°C' | cut -d'.' -f1)

echo "$cpu_temp"

