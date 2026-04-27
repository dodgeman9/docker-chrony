#!/bin/sh

# Default to common pools if the variable is empty
if [ -z "$NTP_SERVERS" ]; then
  NTP_SERVERS="0.pool.ntp.org 1.pool.ntp.org"
fi

# Build the server lines for chrony.conf
SERVER_LINES=""
for s in $NTP_SERVERS; do
  SERVER_LINES="${SERVER_LINES}server $s iburst\n"
done

# Replace the placeholder in our config file
sed -i "s|NTP_SERVERS_PLACEHOLDER|$(printf "$SERVER_LINES")|g" /etc/chrony/chrony.conf

# Start chronyd
# -d: debug/foreground mode
# -x: don't control the system clock (ideal for containers)
exec /usr/sbin/chronyd -d -x
