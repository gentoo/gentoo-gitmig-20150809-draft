# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/aa-sources/aa-sources-2.4.23-r1.ebuild,v 1.5 2004/01/08 15:14:15 iggy Exp $

IUSE="build"

# OKV=original kernel version, KV=patched kernel version.  

ETYPE="sources"

inherit kernel

# AAV=andrea arcangeli release version
AAV=aa${PR/r/}
# KV=patched kernel version
KV="${PV/_/-}-${AAV}"
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

# If it's a last-stable+pre/rc+aa (marcelo), we need to handle it differently
# ourkernel is the stable kernel we'll be working with (previous or current)
if [ ${PRERC} ]; then
	OURKERNEL="2.4.${OKVLASTPR}"
	SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OURKERNEL}.tar.bz2
		mirror://kernel/linux/kernel/people/andrea/kernels/v2.4/${KV/-}.bz2
		mirror://kernel/linux/kernel/v2.4/testing/patch-${PV/_/-}.bz2"
else
	OURKERNEL="2.4.${OKVLAST}"
	SRC_URI="mirror://kernel//linux/kernel/v2.4/linux-${OURKERNEL}.tar.bz2
		mirror://kernel/linux/kernel/people/andrea/kernels/v2.4/${KV/-}.bz2"
fi


DESCRIPTION="Full sources for Andrea Arcangeli's Linux kernel"
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

	bzcat ${DISTDIR}/${KV/-}.bz2|patch -p1 || die "-aa patch failed"
	sed -e '51i \				   qsort.o \\' -i fs/xfs/support/Makefile

	epatch ${FILESDIR}/${P}.CAN-2003-0985.patch || die "Failed to apply mremap() patch!"
	epatch ${FILESDIR}/${P}.rtc_fix.patch || die "Failed to apply RTC patch!"

	kernel_universal_unpack
}
