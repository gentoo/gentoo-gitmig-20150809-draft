# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-skinsoppalusikka/files/rc-addon.sh,v 1.1 2006/03/06 19:59:21 hd_brummy Exp $
#
# rc-addon plugin-startup-skript for vdr-skinsoppalusikka
#

plugin_pre_vdr_start() {

  : ${SKINSOPPALUSIKKA_LOGOS_DIR:=/usr/share/vdr/skinsoppalusikka/logos}

  add_plugin_param "-l ${SKINSOPPALUSIKKA_LOGOS_DIR}"

}

# for compatibility
if [[ ${SCRIPT_API:-1} -lt 2 ]]; then
    plugin_pre_vdr_start
fi
 
