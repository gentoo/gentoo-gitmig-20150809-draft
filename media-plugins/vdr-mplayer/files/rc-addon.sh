# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-mplayer/files/rc-addon.sh,v 1.1 2006/01/08 21:37:58 hd_brummy Exp $
#
# rc-addon plugin-startup-skript for vdr-mplayer
#

MPLAYER_PLUGIN_MOUNT="/usr/share/vdr/mplayer/bin/mount-mplayer.sh"
MPLAYER_PLUGIN_CALL="/usr/share/vdr/mplayer/bin/mplayer.sh"

plugin_pre_vdr_start() {

    add_plugin_param "-m ${MPLAYER_PLUGIN_MOUNT}"
    add_plugin_param "-M ${MPLAYER_PLUGIN_CALL}"
				
}

		
# for compatibility
	if [[ ${SCRIPT_API:-1} -lt 2 ]]; then
      plugin_pre_vdr_start
	fi
