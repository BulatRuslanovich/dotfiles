POSITION=$(playerctl --player=chromium position)
LENGTH_MICROSECONDS=$(playerctl metadata --format "{{mpris:length}}")

PERCENTAGE=$(python3 -c "
import sys
position = float(sys.argv[1])
length_seconds = float(sys.argv[2]) / 1000000
percentage = (position / length_seconds) * 100
print(f'{percentage:.2f}')
" "$POSITION" "$LENGTH_MICROSECONDS")

echo "$PERCENTAGE"
