#!/sbin/runscript
# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

depend() {
	need bootmisc
}

checkconfig() {
	/sbin/chpax -v /sbin/chpax >/dev/null 2>&1 || return 1
}

start() {
	checkconfig || return 1

	local err_msg="error running chpax on "

	for x in ${PAGEEXEC_EXEMPT} ; do
		[ -f ${x} ] && /sbin/chpax -p ${x} || eerror ${err_msg} ${x}
	done

	for x in ${TRAMPOLINE_EXEMPT} ; do
		[ -f ${x} ] && /sbin/chpax -e ${x} || eerror ${err_msg} ${x}
	done

	for x in ${MMAP_EXEMPT} ; do
		[ -f ${x} ] && /sbin/chpax -r ${x} || eerror ${err_msg} ${x}
	done

	for x in ${MPROTECT_EXEMPT} ; do
		[ -f ${x} ] && /sbin/chpax -m ${x} || eerror ${err_msg} ${x}
	done

	for x in ${SEGEXEC_EXEMPT} ; do
		[ -f ${x} ] && /sbin/chpax -s ${x} || eerror ${err_msg} ${x}
	done

	for x in ${RANDEXEC_EXEMPT} ; do
		[ -f ${x} ] && /sbin/chpax -x ${x} || eerror ${err_msg} ${x}
	done

}

stop() {
	return 0
}

