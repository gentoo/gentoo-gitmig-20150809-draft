#!/sbin/runscript
# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/cpufreqd/files/cpufreqd-2.0.0-init.d,v 1.2 2006/02/14 13:34:50 brix Exp $

CONFIGFILE=/etc/cpufreqd.conf

depend() {
	need localmount
	use logger
}

checkconfig() {
	if [[ ! -f ${CONFIGFILE} ]]; then
		eerror "Configuration file ${CONFIGFILE} not found"
		return 1
	fi

	if [[ ! -e /proc/cpufreq ]] && [[ ! -e /sys/devices/system/cpu/cpu0/cpufreq ]]; then
		eerror "cpufreqd requires the kernel to be configured with CONFIG_CPU_FREQ"
		return 1
	fi
}

start() {
	checkconfig || return 1

	ebegin "Starting CPU Frequency Daemon"
	start-stop-daemon --start --exec /usr/sbin/cpufreqd -- \
		-f ${CONFIGFILE}
	eend ${?}
}

stop() {
	ebegin "Stopping CPU Frequency Daemon"
	start-stop-daemon --stop --exec /usr/sbin/cpufreqd
	eend ${?}
}
