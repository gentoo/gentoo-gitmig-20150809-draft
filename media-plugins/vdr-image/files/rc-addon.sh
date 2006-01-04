# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-image/files/rc-addon.sh,v 1.1 2006/01/04 17:03:52 hd_brummy Exp $
#
# rc-addon plugin-startup-skript for vdr-image
#

IMAGE_MOUNT="/usr/bin/mount-image.sh"
IMAGE_CONVERT="/usr/bin/imageplugin.sh"

plugin_pre_vdr_start() {

	add_plugin_param "-m ${IMAGE_MOUNT}"
	add_plugin_param "-C ${IMAGE_CONVERT}"

}


# for compatibility
if [[ ${SCRIPT_API:-1} -lt 2 ]]; then
    plugin_pre_vdr_start
fi
