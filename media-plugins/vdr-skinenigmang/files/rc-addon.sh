# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-skinenigmang/files/rc-addon.sh,v 1.1 2007/03/06 14:40:13 hd_brummy Exp $
#
# rc-addon-script for plugin skinenigmang
#
# Joerg Bornkessel hd_brummy@gentoo.org

SKINENIGMANG_LOGODIR="/usr/share/vdr/skinenigmang"

plugin_pre_vdr_start() {

  add_plugin_param "-l ${SKINENIGMANG_LOGODIR}"
}

# for compatibility
if [[ ${SCRIPT_API:-1} -lt 2 ]]; then
  plugin_pre_vdr_start
fi
 		 
