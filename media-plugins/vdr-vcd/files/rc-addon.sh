# plugin-startup-skript for vcd-plugin

plugin_pre_vdr_start() {
	[[ -e /etc/conf.d/vdr.cd-dvd ]] && source /etc/conf.d/vdr.cd-dvd
	: ${VDR_CDREADER:=/dev/cdrom}
	: ${VCD_DEVICE:=${VDR_CDREADER}}
	add_plugin_param "--vcd ${VCD_DEVICE}"
}

# for compatibility
if [[ ${SCRIPT_API:-1} -lt 2 ]]; then
	plugin_pre_vdr_start
fi
