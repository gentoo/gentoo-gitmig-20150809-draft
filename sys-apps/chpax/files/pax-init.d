#!/sbin/runscript
# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

depend() {
	need bootmisc
}

checkconfig() {
	if [ "x$CHPAX" = "x" ]; then
		#CHPAX=/sbin/paxctl
		CHPAX=/sbin/chpax
	fi
	$CHPAX -v $CHPAX >/dev/null 2>&1 || return 1
}

chpax_flag() {
	flag=$1
	fname=$2

	#einfo "chpax -$flag ${fname}"
	if [ -w ${fname} ]; then
		einfo "$CHPAX -$flag ${fname}"
		$CHPAX -$flag ${fname}
		[ $? != 0 ] && eerror "error: $CHPAX -$flag ${fname}"
	fi
}

fix_exempts() {
	#need to do this for foo{,bar,baz} expressions to work.
	PAGEEXEC_EXEMPT=`eval echo $PAGEEXEC_EXEMPT`
	TRAMPOLINE_EXEMPT=`eval echo $TRAMPOLINE_EXEMPT`
	RANDMMAP_EXEMPT=`eval echo $RANDMMAP_EXEMPT`
	MPROTECT_EXEMPT=`eval echo $MPROTECT_EXEMPT`
	SEGMEXEC_EXEMPT=`eval echo $SEGMEXEC_EXEMPT`
	RANDEXEC_EXEMPT=`eval echo $RANDEXEC_EXEMPT`
}

start() {
	checkconfig || return 1

	fix_exempts

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
	fix_exempts
	einfo "chpax zero flag masking"
	for p in $PAGEEXEC_EXEMPT; do chpax_flag z ${p} ;done
	for e in $TRAMPOLINE_EXEMPT; do chpax_flag z ${e} ;done
	for r in $RANDMMAP_EXEMPT; do chpax_flag z ${r} ;done
	for m in $MPROTECT_EXEMPT; do chpax_flag z ${m} ;done
	for s in $SEGMEXEC_EXEMPT; do chpax_flag z ${s} ;done
	for x in $RANDEXEC_EXEMPT; do chpax_flag z ${x} ;done

	return 0
}

