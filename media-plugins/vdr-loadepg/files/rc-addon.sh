# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-loadepg/files/rc-addon.sh,v 1.1 2006/08/12 19:31:21 hd_brummy Exp $
#
# rc-addon-script for plugin loadepg
#
# Joerg Bornkessel hd_brummy@gentoo.org 
# Gentoo-VDR-Project vdr@gentoo.org
# 

LOADEPG_CONFDIR="/etc/vdr/plugins/loadepg"

plugin_pre_vdr_start() {

	add_plugin_param "-c ${LOADEPG_CONFDIR}"
}
		
# for compatibility
if [[ ${SCRIPT_API:-1} -lt 2 ]]; then
	plugin_pre_vdr_start
fi