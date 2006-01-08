#
# rc-addon-script for plugin osdteletext
#
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-graphlcd/files/rc-addon.sh,v 1.1 2006/01/08 15:36:55 hd_brummy Exp $

plugin_pre_vdr_start() {
	: ${GRAPHLCD_DIR:=/etc/vdr/plugins/graphlcd/graphlcd.conf}
	: ${GRAPHLCD_DISPLAY:=t6963c}

	add_plugin_param "-c ${GRAPHLCD_DIR}"
	add_plugin_param "-d ${GRAPHLCD_DISPLAY}"
}

# for compatibility
if [[ ${SCRIPT_API:-1} -lt 2 ]]; then
	plugin_pre_vdr_start
fi
