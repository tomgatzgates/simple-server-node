#!/bin/sh
while true; do

	# Clean up previously running apps, gracefully at first then harshly
	killall -TERM epiphany 2>/dev/null;
	killall -TERM matchbox-window-manager 2>/dev/null;
	sleep 2;
	killall -9 epiphany 2>/dev/null;
	killall -9 matchbox-window-manager 2>/dev/null;

	# Clean out existing profile information
	rm -rf /root/.cache;
	rm -rf /root/.config;
	rm -rf /root/.pki;

	# Generate the bare minimum to keep Chromium happy!
	# mkdir -p /root/.config/epiphany/Default
	# sqlite3 /root/.config/epiphany/Default/Web\ Data "CREATE TABLE meta(key LONGVARCHAR NOT NULL UNIQUE PRIMARY KEY, value LONGVARCHAR); INSERT INTO meta VALUES('version','46'); CREATE TABLE keywords (foo INTEGER);";

	# Disable DPMS / Screen blanking
	xset -dpms
	xset s off

	# Reset the framebuffer's colour-depth
	fbset -depth $( cat /sys/module/*fb*/parameters/fbdepth );

	# Hide the cursor (move it to the bottom-right, comment out if you want mouse interaction)
	xwit -root -warp $( cat /sys/module/*fb*/parameters/fbwidth ) $( cat /sys/module/*fb*/parameters/fbheight )

	# Start the window manager (remove "-use_cursor no" if you actually want mouse interaction)
	matchbox-window-manager -use_titlebar no -use_cursor no &

    # chrome data directory
    rm -rf /data/chrome
    [ ! -d /data/chrome ] && mkdir -p /data/chrome

  mkdir ~/.config
	epiphany-browser -a --profile ~/.config https://www.bbc.co.uk

done;
