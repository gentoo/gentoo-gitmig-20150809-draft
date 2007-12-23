# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-graphtft/files/rc-addon.sh,v 1.1 2007/12/23 22:05:10 hd_brummy Exp $
#
# rc-addon-script for plugin graphtft & graphtft-fe
#
# Joerg Bornkessel <hd_brummy@g.o>

plugin_pre_vdr_start() {

		: ${GRAPHTFT_DEVICE:=/dev/fb0}

		add_plugin_param "-d ${GRAPHTFT_DEVICE}"
}
