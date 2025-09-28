#!/bin/bash

free_memory=$(free -h | awk '/Mem:/ {print $7}')

# Print the free memory
echo "$free_memory"

