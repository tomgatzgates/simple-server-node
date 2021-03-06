# base-image for node on any machine using a template variable,
# see more about dockerfile templates here: http://docs.resin.io/deployment/docker-templates/
# and about resin base images here: http://docs.resin.io/runtime/resin-base-images/
# Note the node:slim image doesn't have node-gyp
FROM resin/rpi-raspbian:latest

RUN apt-get update && apt-get install -yq \
  matchbox \
  epiphany-browser \
  chromium-browser \
  x11-xserver-utils \
  ttf-mscorefonts-installer \
  xwit \
  sqlite3 \
  libnss3 \
  xinit \
  supervisor \
  vim \
  xserver-xorg-core \
  fbset \
  alsa-utils \
  xautomation \
  libasound2-dev && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# Configure Supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Configure Chromium
COPY display/config.txt /boot/config.txt
COPY display/rc.local /etc/rc.local
COPY display/xinitrc.sh /root/.xinitrc
COPY display/startx.sh /startx.sh

# Open HTTP & CUPS ports
EXPOSE 8080

CMD ["/usr/bin/supervisord"]
