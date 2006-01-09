# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-radio/files/rc-addon.sh,v 1.1 2006/01/09 21:45:42 hd_brummy Exp $
#
# rc-addon plugin-startup-skript for vdr-radio
# 

RADIO_BACKGROUND_DIR=/usr/share/vdr/radio

plugin_pre_vdr_start() {

    add_plugin_param "-f ${RADIO_BACKGROUND_DIR}"

}
					
# make it comp to old VDR Versions
if [[ ${SCRIPT_API:-1} -lt 2 ]]; then
    plugin_pre_vdr_start
fi 