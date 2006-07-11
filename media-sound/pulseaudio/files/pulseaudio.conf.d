# Config file for /etc/init.d/pulseaudio

# For more see "pulseaudio -h".


# Startup options

# Daemonize, fail if startup fails
PULSEAUDIO_START="-D --fail=true --log-target=syslog"

# Local only (useful for root-only soundcard access)
#PULSEAUDIO_OPTIONS=""

