# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-weatherng/files/rc-addon.sh,v 1.1 2006/03/07 23:27:21 hd_brummy Exp $
#
# rc-addon-script for plugin weatherng
#

plugin_pre_vdr_start() {
	[[ -z "${WEATHERNG_IMAGE_DIR}" ]] && WEATHERNG_IMAGE_DIR="/usr/share/vdr/weatherng"
	add_plugin_param "-I ${WEATHERNG_IMAGE_DIR}"

	[[ -z "${WEATHERNG_DATA_DIR}" ]] && WEATHERNG_DATA_DIR="/var/vdr/weatherng"
	add_plugin_param "-D ${WEATHERNG_DATA_DIR}"
}

# for compatibility
if [[ ${SCRIPT_API:-1} -lt 2 ]]; then
	plugin_pre_vdr_start
fi
