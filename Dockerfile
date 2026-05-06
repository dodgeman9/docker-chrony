FROM alpine:3.18

# Install chrony
RUN apk add --no-cache chrony

# Copy our files into the image
COPY chrony.conf /etc/chrony/chrony.conf
COPY entrypoint.sh /entrypoint.sh

# Ensure the script is executable
RUN chmod +x /entrypoint.sh

# NTP standard port
EXPOSE 123/udp

ENTRYPOINT ["/entrypoint.sh"]
