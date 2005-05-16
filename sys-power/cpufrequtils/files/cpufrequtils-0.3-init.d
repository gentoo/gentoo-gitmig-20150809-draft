#!/sbin/runscript
# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/cpufrequtils/files/cpufrequtils-0.3-init.d,v 1.1 2005/05/16 12:10:43 brix Exp $

checkconfig() {
	if [[ -z "${GOVERNOR}" ]]; then
		eerror "No governor set in /etc/conf.d/cpufrequtils"
		return 1
	fi
}

start() {
	checkconfig || return 1

	ebegin "Enabling ${GOVERNOR} cpufreq governor"
	cpufreq-set -g ${GOVERNOR}
	eend ${?}
}
