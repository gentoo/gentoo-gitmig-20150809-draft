# Config file for /etc/init.d/esound

# Note: You need to start esound on boot, only if you want to use it over network.

# For more see "esd -h".


# Startup options

# Do not beep on start. Free device after 2 sec.
ESD_START="-nobeeps -as 2"


# Network behavior. Use one of following.

# Local only (useful for root-only soundcard access)
#ESD_OPTIONS=""

# Public TCP access.
ESD_OPTIONS="-tcp -public"

# TCP access with bind to address.
#ESD_OPTIONS="-tcp -bind $HOSTNAME"
