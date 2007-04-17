# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-image/files/rc-addon.sh,v 1.4 2007/04/17 09:45:24 zzam Exp $
#
# rc-addon plugin-startup-skript for vdr-image
#

: ${IMAGE_MOUNT:=/usr/share/vdr/image/bin/mount-image.sh}
: ${IMAGE_CONVERT:=/usr/share/vdr/image/bin/imageplugin.sh}

plugin_pre_vdr_start() {
	add_plugin_param "-m ${IMAGE_MOUNT}"
	add_plugin_param "-C ${IMAGE_CONVERT}"
	
	if [ -f /usr/lib/vdr/inc/commands-functions.sh ]; then
		. /usr/lib/vdr/inc/commands-functions.sh
	else
		#source /usr/share/vdr/inc/functions.sh
		include commands-functions
	fi

	merge_commands_conf /etc/vdr/imagecmds /etc/vdr/plugins/image/imagecmds.conf "${ORDER_IMAGECMDS}"
}
