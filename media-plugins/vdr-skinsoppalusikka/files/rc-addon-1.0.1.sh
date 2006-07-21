# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-skinsoppalusikka/files/rc-addon-1.0.1.sh,v 1.1 2006/07/21 21:40:48 hd_brummy Exp $
#
# rc-addon plugin-startup-skript for vdr-skinsoppalusikka
#
# This sript is called by gentoo-vdr-scripts on start of VDR

# Check on dxr-3 and set default logo DIR
plugin_pre_vdr_start() {

	if [[ -z ${PLUGINS/dxr3/} ]] ; then
		: ${SKINSOPPALUSIKKA_LOGOS_DIR:=/usr/share/vdr/skinsoppalusikka/logos}
	else
		: ${SKINSOPPALUSIKKA_LOGOS_DIR:=/usr/share/vdr/skinsoppalusikka/logos-dxr3}
	fi
  
	add_plugin_param "-l ${SKINSOPPALUSIKKA_LOGOS_DIR}"

}

# for compatibility
if [[ ${SCRIPT_API:-1} -lt 2 ]]; then
    plugin_pre_vdr_start
fi
 
