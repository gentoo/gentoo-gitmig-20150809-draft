# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-weatherng/files/rc-addon-0.0.8.sh,v 1.1 2006/03/18 16:44:06 hd_brummy Exp $
#
# rc-addon-script for plugin weatherng
#
# Joerg Borrnkessel <hd_brummy@gentoo.org>

# set default image DIR
: ${WEATHERNG_IMAGE_DIR:=/usr/share/vdr/weatherng}

# set default date DIR
: ${WEATHERNG_DATA_DIR:=/var/vdr/weatherng}

# set default path to weatherng.sh
WEATHERNG_BIN_DIR=/var/vdr/weatherng

plugin_pre_vdr_start() {

	add_plugin_param "-D ${WEATHERNG_DATA_DIR}"

	add_plugin_param "-I ${WEATHERNG_IMAGE_DIR}"

	add_plugin_param "-S ${WEATHERNG_BIN_DIR}"
}

# for compatibility
if [[ ${SCRIPT_API:-1} -lt 2 ]]; then
	plugin_pre_vdr_start
fi
