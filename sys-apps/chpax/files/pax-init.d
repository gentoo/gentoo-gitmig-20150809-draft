#!/sbin/runscript
# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

depend() {
	need bootmisc
}

checkconfig() {
	/sbin/chpax -v /sbin/chpax >/dev/null 2>&1 || return 1
}

chpax_flag() {
	flag=$1
	fname=$2

	if [ -w "$fname" ]; then
		#einfo "chpax $flags $fname"
		/sbin/chpax -$flag ${fname}
		[ $? != 0 ] && eerror "error: chpax -$flag ${fname}"
	fi
}

start() {
	checkconfig || return 1

	for p in $PAGEEXEC_EXEMPT; do chpax_flag p ${p} ;done
	for e in $TRAMPOLINE_EXEMPT; do chpax_flag e ${e} ;done
	for r in $RANDMMAP_EXEMPT; do chpax_flag r ${r} ;done
	for m in $MPROTECT_EXEMPT; do chpax_flag m ${m} ;done
	for s in $SEGMEXEC_EXEMPT; do chpax_flag s ${s} ;done
	for x in $RANDEXEC_EXEMPT; do chpax_flag x ${x} ;done

	return 0
}

stop() {
	checkconfig || return 1

	[ "$ZERO_FLAG_MASK" = "yes" ] || return 0
	einfo "chpax zero flag masking"
	for p in $PAGEEXEC_EXEMPT; do chpax_flag z ${p} ;done
	for e in $TRAMPOLINE_EXEMPT; do chpax_flag z ${e} ;done
	for r in $RANDMMAP_EXEMPT; do chpax_flag z ${r} ;done
	for m in $MPROTECT_EXEMPT; do chpax_flag z ${m} ;done
	for s in $SEGMEXEC_EXEMPT; do chpax_flag z ${s} ;done
	for x in $RANDEXEC_EXEMPT; do chpax_flag z ${x} ;done

	return 0
}

