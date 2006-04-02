# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-ffnetdev/files/rc-addon.sh,v 1.1 2006/04/02 15:50:28 hd_brummy Exp $
#
# rc-addon-script for plugin ffnetdev
#
# Joerg Bornkessel <hd_brummy@gentoo.org>

: ${VNC_PORT:=20001}
: ${TS_PORT:=20002}

plugin_pre_vdr_start() {

  [[ ${USE_VNC} == "yes" ]] && add_plugin_param "-o ${VNC_PORT}"

  [[ ${USE_TS} == "yes" ]] && add_plugin_param "-t  ${TS_PORT}"

  [[ ${REMOTE} == "yes" ]] && add_plugin_param "-e"
}

# for compatibility
if [[ ${SCRIPT_API:-1} -lt 2 ]]; then
  plugin_pre_vdr_start
fi 