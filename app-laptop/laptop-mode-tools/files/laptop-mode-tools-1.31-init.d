#!/sbin/runscript
# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/laptop-mode-tools/files/laptop-mode-tools-1.31-init.d,v 1.1 2006/04/18 09:56:24 brix Exp $

opts="${opts} reload"

checkconfig() {
    if [[ ! -f /proc/sys/vm/laptop_mode ]]; then
		eerror "Kernel does not support laptop_mode"
		return 1
    fi
}

start() {
    checkconfig || return 1

    ebegin "Starting laptop_mode"
    touch /var/run/laptop-mode-enabled
	/usr/sbin/laptop_mode auto init &> /dev/null
    eend ${?}
}

stop() {
    ebegin "Stopping laptop_mode"
    rm -f /var/run/laptop-mode-enabled
    /usr/sbin/laptop_mode stop init &> /dev/null
    eend ${?}
}

reload() {
    ebegin "Restarting laptop_mode"
    /usr/sbin/laptop_mode auto init force &> /dev/null
    eend ${?}
}
