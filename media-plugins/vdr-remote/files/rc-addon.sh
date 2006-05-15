#
# rc-addon-script for plugin remote
#

check_device() {
	local handlers="${1}"
	local name="${2}"
	local eventdev=""
	[[ "${handlers}" == "" ]] && return

	for handler in ${handlers}; do
		case ${handler} in
		event*)
			eventdev=${handler}
			;;
		esac
	done
	if [[ "${eventdev}" == "" ]]; then
		[[ "${evdev_warning_showed}" != "1" ]] \
		&& echo "you need to load module evdev for autodetect input-devices to work"
		evdev_warning_showed=1
		return
	fi
	if [[ (${name/dvb/} != ${name}) || (${name/DVB/} == ${name}) ]]; then
		return
	fi
	
	einfo_level1 "Autodetect Input Device ${eventdev} (Name: ${name})"
	REMOTE_PLUGIN_INPUT_DEVICE="${REMOTE_PLUGIN_INPUT_DEVICE} /dev/input/${eventdev}"
	return
}

autodetect_input_devices() {
	[[ -e /proc/bus/input/devices ]] || return
	exec 3</proc/bus/input/devices
	while read -u 3 line; do
		case ${line} in
		I:*)	check_device "${device}" "${name}" 
			device=""
			;;
		H:*)	device=${line#H: Handlers=}
			;;
		N:*)	name=${line#N: Name=\"}
			name=${name%\"}
			;;
		esac
	done
	check_device "${device}" "${name}"
	exec 3<&-
}

plugin_pre_vdr_start() {
	if [[ ${REMOTE_PLUGIN_INPUT_DEVICE:-autodetect} == "autodetect" ]]; then
		REMOTE_PLUGIN_INPUT_DEVICE=""
		autodetect_input_devices
	fi
	if [[ -n ${REMOTE_PLUGIN_INPUT_DEVICE} && "${REMOTE_PLUGIN_INPUT_DEVICE}" != "no" ]]; then
		[[ -e /proc/av7110_ir ]] && chown vdr:vdr /proc/av7110_ir
		for dev in ${REMOTE_PLUGIN_INPUT_DEVICE}; do
			[[ -e ${dev} ]] || continue
			chown vdr:vdr ${dev}
			add_plugin_param "--input=${dev}"
		done
	fi

	if [[ -n ${REMOTE_PLUGIN_LIRC} ]]; then
		for dev in ${REMOTE_PLUGIN_LIRC}; do
			[[ -e ${dev} ]] || continue
			add_plugin_param "--lirc=${dev}"
		done
	fi

	if [[ -n ${REMOTE_PLUGIN_TCP_PORTS} ]]; then
		for tcpport in ${REMOTE_PLUGIN_TCP_PORTS}; do
			add_plugin_param "--port=tcp:${tcpport}"
		done
	fi

	if [[ -n ${REMOTE_PLUGIN_TTY_ONLY_INPUT} ]]; then
		for tty in ${REMOTE_PLUGIN_TTY_ONLY_INPUT}; do
			[[ -e ${tty} ]] || continue
			chown vdr:vdr ${tty}
			add_plugin_param "--tty=${tty}"
		done
	fi

	if [[ -n ${REMOTE_PLUGIN_TTY_WITH_OSD} ]]; then
		for tty in ${REMOTE_PLUGIN_TTY_WITH_OSD}; do
			[[ -e ${tty} ]] || continue
			chown vdr:vdr ${tty}
			add_plugin_param "--TTY=${tty}"
		done
	fi
}

# for compatibility
if [[ ${SCRIPT_API:-1} -lt 2 ]]; then
	plugin_pre_vdr_start
fi
