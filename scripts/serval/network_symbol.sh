#!/bin/bash
# For use with Waybar
# Return a "100" if on Ethernet, a "50" if on WiFi, a "0" if disconnected

case "$(ip route list | grep -Po 'default.*dev \K\w' | head -n 1)" in
  'w') echo ' '
  ;;
  'e') echo '󰈀 '
  ;;
  *) echo ' '
  ;;
esac
