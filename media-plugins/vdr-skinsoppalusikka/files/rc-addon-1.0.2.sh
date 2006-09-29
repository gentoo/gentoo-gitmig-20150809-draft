# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-skinsoppalusikka/files/rc-addon-1.0.2.sh,v 1.2 2006/09/29 21:51:58 hd_brummy Exp $
#
# rc-addon plugin-startup-skript for vdr-skinsoppalusikka
#
# This sript is called by gentoo-vdr-scripts on start of VDR

# Check if dxr3 plugin in /etc/conf.d/vdr Plugins=""
# and set default logo DIR

plugin_pre_vdr_start() {

	if [[ ${PLUGINS} != ${PLUGINS/dxr3/} ]] ; then
		: ${SKINSOPPALUSIKKA_LOGOS_DIR:=/usr/share/vdr/skinsoppalusikka/logos-dxr3}
	else
		: ${SKINSOPPALUSIKKA_LOGOS_DIR:=/usr/share/vdr/channel-logos}
	fi
  
	add_plugin_param "-l ${SKINSOPPALUSIKKA_LOGOS_DIR}"

}

# for compatibility
if [[ ${SCRIPT_API:-1} -lt 2 ]]; then
    plugin_pre_vdr_start
fi
 
