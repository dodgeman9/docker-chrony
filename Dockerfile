FROM alpine:3.21

# Install chrony and tzdata (for TZ environment variable support)
RUN apk add --no-cache chrony tzdata

# Copy our files into the image
COPY chrony.conf /etc/chrony/chrony.conf
COPY entrypoint.sh /entrypoint.sh

# Ensure the script is executable
RUN chmod +x /entrypoint.sh

# NTP standard port
EXPOSE 123/udp

# Healthcheck to verify chrony is running and responding
HEALTHCHECK --interval=60s --timeout=5s --start-period=10s --retries=3 \
  CMD chronyc tracking || exit 1

ENTRYPOINT ["/entrypoint.sh"]
