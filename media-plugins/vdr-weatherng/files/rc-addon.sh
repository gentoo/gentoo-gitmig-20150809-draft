# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-weatherng/files/rc-addon.sh,v 1.2 2007/04/17 09:43:15 zzam Exp $
#
# rc-addon-script for plugin weatherng
#

plugin_pre_vdr_start() {
	[ -z "${WEATHERNG_IMAGE_DIR}" ] && WEATHERNG_IMAGE_DIR="/usr/share/vdr/weatherng"
	add_plugin_param "-I ${WEATHERNG_IMAGE_DIR}"

	[ -z "${WEATHERNG_DATA_DIR}" ] && WEATHERNG_DATA_DIR="/var/vdr/weatherng"
	add_plugin_param "-D ${WEATHERNG_DATA_DIR}"
}

