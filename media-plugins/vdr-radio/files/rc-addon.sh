# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-radio/files/rc-addon.sh,v 1.2 2006/07/22 19:57:21 hd_brummy Exp $
#
# rc-addon plugin-startup-skript for vdr-radio
# 
# This sript is called by gentoo-vdr-scripts on start of VDR

# Set default DIR to the background picture
RADIO_BACKGROUND_DIR=/usr/share/vdr/radio

plugin_pre_vdr_start() {

    add_plugin_param "-f ${RADIO_BACKGROUND_DIR}"

}
					
# make it comp to old VDR Versions
if [[ ${SCRIPT_API:-1} -lt 2 ]]; then
    plugin_pre_vdr_start
fi 