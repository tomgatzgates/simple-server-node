#/bin/bash

# Disable DPMS / Screen blanking
 xset -dpms
 xset s off
 xset s noblank

rm -rf /root/.config
mkdir -p /root/.config
url=$URL
default='https://www.ordermygear.com'
sudo matchbox-window-manager -use_titlebar no -use_cursor no &
xte 'sleep 15' 'key F11'&
epiphany-browser -a --profile /root/.config 'http://localhost:80' --display=:0

unclutter -idle 0.1 -root
sleep 2s
