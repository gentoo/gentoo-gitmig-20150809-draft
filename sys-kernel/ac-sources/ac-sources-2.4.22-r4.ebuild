# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ac-sources/ac-sources-2.4.22-r4.ebuild,v 1.3 2004/01/06 15:48:55 plasmaroo Exp $

IUSE="build"

# OKV=original kernel version, KV=patched kernel version.

ETYPE="sources"

inherit kernel

# ACV=alan cox release version
ACV=ac${PR/r/}
# KV=patched kernel version
KV="${PV/_/-}-${ACV}"
# OKV=original kernel version as provided by ebuild
OKV="`echo ${KV} | cut -d- -f1`"
# OKVLAST=(working) last digit of OKV
OKVLAST="`echo ${OKV} | cut -d. -f3`"
# OKVLASTPR=the previous kernel version (for a marcelo pre/rc release)
OKVLASTPR="`expr ${OKVLAST} - 1`"
# If _ isn't there, then it's a stable+ac, otherwise last-stable+pre/rc+ac
PRERC="`echo ${PV}|grep \_`"

# Other working variables
S=${WORKDIR}/linux-${KV}
EXTRAVERSION="`echo ${KV}|sed -e 's:[^-]*\(-.*$\):\1:'`"
BASE="`echo ${KV}|sed -e s:${EXTRAVERSION}::`"

DESCRIPTION="Full sources for Alan Cox's Linux kernel"

# If it's a last-stable+pre/rc+ac (marcelo), we need to handle it differently
# ourkernel is the stable kernel we'll be working with (previous or current)
if [ ${PRERC} ]; then
	OURKERNEL="2.4.${OKVLASTPR}"
	SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OURKERNEL}.tar.bz2
		mirror://kernel/linux/kernel/people/alan/linux-2.4/${BASE}/patch-${KV}.bz2
		mirror://kernel/linux/kernel/v2.4/testing/patch-${PV/_/-}.bz2"
else
	OURKERNEL="2.4.${OKVLAST}"
	SRC_URI="mirror://kernel//linux/kernel/v2.4/linux-${OURKERNEL}.tar.bz2
		mirror://kernel/linux/kernel/people/alan/linux-2.4/${BASE}/patch-${KV}.bz2"
	fi

KEYWORDS="x86"
SLOT="${KV}"

src_unpack() {
	sleep 1
	unpack linux-${OURKERNEL}.tar.bz2
	mv linux-${OURKERNEL} linux-${KV} || die

	cd linux-${KV}

	# if we need a pre/rc patch, then use it
	if [ ${PRERC} ]; then
		bzcat ${DISTDIR}/patch-${PV/_/-}.bz2|patch -p1 || die "-marcelo patch failed"
	fi

	bzcat ${DISTDIR}/patch-${KV}.bz2|patch -p1 || die "-ac patch failed"

	epatch ${FILESDIR}/do_brk_fix.patch || die "Failed to patch do_brk() vulnerability!"
	epatch ${FILESDIR}/${PN}.CAN-2003-0985.patch || die "Failed to patch mremap() vulnerability!"
	epatch ${FILESDIR}/${PN}.rtc_fix.patch || die "Failed to patch RTC vulnerabilities!"

	kernel_universal_unpack
}
