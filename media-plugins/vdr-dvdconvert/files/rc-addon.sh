# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-dvdconvert/files/rc-addon.sh,v 1.1 2007/01/07 01:29:35 hd_brummy Exp $
#
# rc-addon-script for plugin dvdconvert
#
# Joerg Bornkessel <hd_brummy@gentoo.org>

DVDCONVERT_CONF="/usr/share/vdr/dvdconvert/dvdconvert.conf"

plugin_pre_vdr_start() {

add_plugin_param "-c ${DVDCONVERT_CONF}"

}

# for compatibility
if [[ ${SCRIPT_API:-1} -lt 2 ]]; then
plugin_pre_vdr_start
fi
