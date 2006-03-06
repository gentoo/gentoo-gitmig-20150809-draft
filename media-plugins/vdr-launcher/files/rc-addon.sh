# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-launcher/files/rc-addon.sh,v 1.1 2006/03/06 06:07:44 zzam Exp $
#
# rc-addon plugin-startup-skript for vdr-launcher
#

plugin_pre_vdr_start() {
	local p
	for p in ${VDR_LAUNCHER_EXCLUDE}; do
		add_plugin_param "-x ${p}"
	done
}


# for compatibility
if [[ ${SCRIPT_API:-1} -lt 2 ]]; then
	plugin_pre_vdr_start
fi
