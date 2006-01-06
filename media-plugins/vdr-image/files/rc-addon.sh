# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-image/files/rc-addon.sh,v 1.2 2006/01/06 01:36:26 zzam Exp $
#
# rc-addon plugin-startup-skript for vdr-image
#

: ${IMAGE_MOUNT:=/usr/share/vdr/image/bin/mount-image.sh}
: ${IMAGE_CONVERT:=/usr/share/vdr/image/bin/imageplugin.sh}

plugin_pre_vdr_start() {
	add_plugin_param "-m ${IMAGE_MOUNT}"
	add_plugin_param "-C ${IMAGE_CONVERT}"
	
	[[ -f /usr/lib/vdr/inc/commands-functions.sh ]] || return
	
	source /usr/lib/vdr/inc/commands-functions.sh
	merge_commands_conf /etc/vdr/imagecmds /etc/vdr/plugins/image/imagecmds.conf "${ORDER_IMAGECMDS}"
}

if [[ ${SCRIPT_API:-1} -lt 2 ]]; then
	plugin_pre_vdr_start
fi

