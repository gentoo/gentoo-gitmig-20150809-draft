#!/sbin/runscript
# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/cpufrequtils/files/cpufrequtils-002-init.d,v 1.1 2006/06/01 12:02:01 brix Exp $

checkconfig() {
	if [ -z "${GOVERNOR}" ]; then
		eerror "No governor set in /etc/conf.d/cpufrequtils"
		return 1
	fi
}

start() {
	local cpu n

	checkconfig || return 1

	for cpu in /sys/devices/system/cpu/*; do
		n=$(basename ${cpu})
		n=${n/cpu/}

		ebegin "Enabling ${GOVERNOR} cpufreq governor on CPU${n}"
		cpufreq-set -c ${n} -g ${GOVERNOR}
		eend ${?}
	done
}
