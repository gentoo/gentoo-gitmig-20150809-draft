# plugin-startup-skript for bitstreamout-plugin

plugin_pre_vdr_start() {
	[[ -n "${BITSTREAMOUT_MUTE}" ]] && "--mute=${BITSTREAMOUT_MUTE}"
}

if [[ ${SCRIPT_API:-1} -lt 2 ]]; then
	plugin_pre_vdr_start
fi

