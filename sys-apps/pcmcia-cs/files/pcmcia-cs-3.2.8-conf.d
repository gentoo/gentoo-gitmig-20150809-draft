# Options for the 'cardmgr' daemon
CARDMGR_OPTS="-f"

# Default PCMCIA scheme
SCHEME="home"

# If using kernel PCMCIA drivers, PCIC should be "yenta_socket". If
# using the pcmcia-cs drivers, PCIC should be either "i82365" or
# "tcic", depending on your hardware.  If using non-modular kernel
# drivers, set PCIC to ""

PCIC="yenta_socket"
# Options for the PCIC module
PCIC_OPTS=""

# Alternative PCIC driver to use if PCIC driver fails
PCIC_ALT="i82365"
PCIC_ALT_OPTS=""

# Options for the pcmcia_core module
CORE_OPTS=""
