#!/sbin/runscript
# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/chpax/files/pax-init.d,v 1.8 2004/09/28 01:49:28 swegener Exp $

depend() {
	need bootmisc
}

checkconfig() {
	if [ "x$CHPAX" = "x" ]; then
		CHPAX="/sbin/chpax /sbin/paxctl"
	fi
	# Find non-existant chpaxes
	REALCHPAX=""
	for i in $CHPAX; do
		REALCHPAX="$REALCHPAX`$i -v $i >/dev/null 2>&1 && echo \ $i`"
	done
	if [ "x$REALCHPAX" = "x" ]; then
		eerror "error:  none of the specified chpax commands exist!"
		return 1
	fi
	CHPAX="$REALCHPAX"
}

chpax_flag() {
	flag=$1
	fname=$2

	#if [ -w ${fname} ]; then
		#einfo "-${flag} flagging ${fname}"
		for i in $CHPAX; do
			#einfo "    with $i"
			# nonverbose is ultraquiet
			if [ "$VERBOSE" = "yes" -a -x ${fname} ]; then
				einfo "-${flag} flagging ${fname} with $i"
				$i -$flag ${fname}
				[ $? != 0 ] && eerror "error: $i -$flag ${fname}"
			else
				[ -x ${fname} ] && $i -$flag ${fname} 2>/dev/null >/dev/null
			fi
		done
	#fi
}

fix_exempts() {
	#need to do this for foo{,bar,baz} expressions to work.
	PAGEEXEC_EXEMPT=`eval echo $PAGEEXEC_EXEMPT`
	TRAMPOLINE_EXEMPT=`eval echo $TRAMPOLINE_EXEMPT`
	RANDMMAP_EXEMPT=`eval echo $RANDMMAP_EXEMPT`
	MPROTECT_EXEMPT=`eval echo $MPROTECT_EXEMPT`
	SEGMEXEC_EXEMPT=`eval echo $SEGMEXEC_EXEMPT`
	PS_EXEC_EXEMPT=`eval echo $PS_EXEC_EXEMPT`
	RANDEXEC_EXEMPT=`eval echo $RANDEXEC_EXEMPT`
}

start() {
	checkconfig || return 1

	fix_exempts

	ebegin "Setting PaX flags on binaries"
	for e in $TRAMPOLINE_EXEMPT; do chpax_flag e ${e}    ;done
	for r in $RANDMMAP_EXEMPT;   do chpax_flag r ${r}    ;done
	for m in $MPROTECT_EXEMPT;   do chpax_flag m ${m}    ;done
	for p in $PAGEEXEC_EXEMPT;   do chpax_flag p ${p}    ;done
	for s in $SEGMEXEC_EXEMPT;   do chpax_flag s ${s}    ;done
	for s in $PS_EXEC_EXEMPT;    do chpax_flag psem ${s} ;done
	for x in $RANDEXEC_EXEMPT;   do chpax_flag x ${x}    ;done

	eend
	return 0
}

stop() {
	checkconfig || return 1

	[ "$ZERO_FLAG_MASK" = "yes" ] || return 0
	fix_exempts
	einfo "chpax zero flag masking"
	for p in $PAGEEXEC_EXEMPT;   do chpax_flag ze ${p} ;done
	for e in $TRAMPOLINE_EXEMPT; do chpax_flag ze ${e} ;done
	for r in $RANDMMAP_EXEMPT;   do chpax_flag ze ${r} ;done
	for m in $MPROTECT_EXEMPT;   do chpax_flag ze ${m} ;done
	for s in $SEGMEXEC_EXEMPT;   do chpax_flag ze ${s} ;done
	for s in $PS_EXEC_EXEMPT;    do chpax_flag ze ${s} ;done
	for x in $RANDEXEC_EXEMPT;   do chpax_flag ze ${x} ;done

	return 0
}


