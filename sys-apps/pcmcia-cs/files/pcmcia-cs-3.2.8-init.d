#!/sbin/runscript
# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pcmcia-cs/files/pcmcia-cs-3.2.8-init.d,v 1.2 2005/05/09 08:57:55 brix Exp $

RUN=/var/run
SCHEME_FILE=${RUN}/pcmcia-scheme

depend() {
	use coldplug
}

cleanup() {
	while read SN CLASS MOD INST DEV EXTRA; do
		if [[ "${SN}" != "Socket" ]]; then
			/etc/pcmcia/${CLASS} stop ${DEV} 2> /dev/null
		fi
	done
}

pcmcia_probe() {
	/sbin/modprobe ${1} ${2} 2> /dev/null
	return ${?}
}

start() {
	local retval

	# Scheme is set for the /etc/pcmcia/shared script
	if [[ -n "${SCHEME}" ]]; then
		umask 022
		echo ${SCHEME} > ${SCHEME_FILE}
	else
		umask 022
		touch ${SCHEME_FILE}
	fi

	# clean up any old interfaces
	if [[ -r ${RUN}/stab ]]; then
		cat ${RUN}/stab | cleanup
	fi

	# if /var/lib/pcmcia exists (and sometimes it gets created
	# accidentally if you run pcmcia-cs apps without the proper
	# flags), then it will really confuse the process
	if [[ -d /var/lib/pcmcia ]]; then
		rm -rf /var/lib/pcmcia
	fi

	if [[ -e /proc/bus/pccard ]]; then
		einfo "PCMCIA support detected"
	else
		pcmcia_probe pcmcia_core ${CORE_OPTS}
		if [[ -n "${PCIC}" ]]; then
			if ! pcmcia_probe ${PCIC} ${PCIC_OPTS}; then
				ewarn "'modprobe ${PCIC}' failed"
				ewarn "Trying alternative PCIC driver: ${PCIC_ALT}"
				pcmcia_probe ${PCIC_ALT} ${PCIC_ALT_OPTS}
			fi
		fi
		pcmcia_probe ds
	fi

	ebegin "Starting pcmcia"
	start-stop-daemon --start --quiet --exec /sbin/cardmgr -- \
		-s ${RUN}/stab ${CARDMGR_OPTS}
	retval=${?}

	if [[ ${retval} -gt 0 ]]; then
		einfo "cardmgr failed to start.  Make sure that you have PCMCIA"
		einfo "modules built or support compiled into the kernel"
	fi

	eend ${retval}
}

stop() {
	local retval

	ebegin "Stopping pcmcia"

	[[ -w ${SCHEME_FILE} ]] && rm -f ${SCHEME_FILE}
	start-stop-daemon --stop --quiet --pidfile /var/run/cardmgr.pid --retry 5
	retval=${?}

	if [[ -e /proc/modules && -n $(fgrep "ds " /proc/modules | head -n1 | cut -c1) ]]; then
		/sbin/rmmod ds 2> /dev/null
		/sbin/rmmod ${PCIC} 2> /dev/null
		/sbin/rmmod ${PCIC_ALT} 2> /dev/null
		/sbin/rmmod pcmcia 2> /dev/null
		/sbin/rmmod pcmcia_core 2> /dev/null
	fi

	eend ${retval}
}

