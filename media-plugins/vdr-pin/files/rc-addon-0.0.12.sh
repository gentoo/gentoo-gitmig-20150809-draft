# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-pin/files/rc-addon-0.0.12.sh,v 1.1 2006/05/05 22:38:03 hd_brummy Exp $
#
# rc-addon-script for plugin pin
#

# DIR should dont exist on plugin start

[[ -e /etc/vdr/plugins/pin ]] && rm -r /etc/vdr/plugins/pin
