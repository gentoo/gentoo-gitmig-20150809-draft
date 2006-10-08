# plugin-config-addon for softdevice
plugin_pre_vdr_start() {
	if [[ -n "${SOFTDEVICE_VIDEO_OUT}" ]]; then
		add_plugin_param "-vo ${SOFTDEVICE_VIDEO_OUT}:${SOFTDEVICE_VIDEO_OUT_SUBOPTS}"
	fi

	if [[ -n "${SOFTDEVICE_AUDIO_OUT}" ]]; then
		add_plugin_param "-ao ${SOFTDEVICE_AUDIO_OUT}:${SOFTDEVICE_AUDIO_OUT_SUBOPTS}"
	fi
}

plugin_pre_vdr_stop() {
	if [[ ${SOFTDEVICE_VIDEO_OUT} == "shm" ]]; then
		killall ShmClient 2>/dev/null
	fi
}

# for compatibility
if [[ ${SCRIPT_API:-1} -lt 2 ]]; then
        plugin_pre_vdr_start
fi

