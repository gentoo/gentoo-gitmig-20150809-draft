# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/aa-sources/aa-sources-2.4.23-r3.ebuild,v 1.1 2004/11/06 20:54:20 plasmaroo Exp $

IUSE=""

# OKV=original kernel version, KV=patched kernel version.

ETYPE="sources"

inherit kernel eutils

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
		mirror://kernel/linux/kernel/v2.4/testing/patch-${PV/_/-}.bz2
		http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/${P}-CAN-2004-0415.patch
		http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/${P}-CAN-2004-0814.patch"
else
	OURKERNEL="2.4.${OKVLAST}"
	SRC_URI="mirror://kernel//linux/kernel/v2.4/linux-${OURKERNEL}.tar.bz2
		mirror://kernel/linux/kernel/people/andrea/kernels/v2.4/${KV/-}.bz2
		http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/${P}-CAN-2004-0415.patch
		http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/${P}-CAN-2004-0814.patch"
fi

DESCRIPTION="Full sources for Andrea Arcangeli's Linux kernel"
KEYWORDS="x86 -ppc"
SLOT="${KV}"

src_unpack() {
	unpack linux-${OURKERNEL}.tar.bz2
	mv linux-${OURKERNEL} linux-${KV} || die
	cd linux-${KV}

	# if we need a pre/rc patch, then use it
	if [ ${PRERC} ]; then
		bzcat ${DISTDIR}/patch-${PV/_/-}.bz2|patch -p1 || die "-marcelo patch failed"
	fi

	bzcat ${DISTDIR}/${KV/-}.bz2|patch -p1 || die "-aa patch failed"
	sed -e '51i \				   qsort.o \\' -i fs/xfs/support/Makefile || die "XFS patch failed!"

	epatch ${FILESDIR}/${P}.CAN-2003-0985.patch || die "Failed to apply mremap() patch!"
	epatch ${FILESDIR}/${P}.CAN-2004-0010.patch || die "Failed to add the CAN-2004-0010 patch!"
	epatch ${FILESDIR}/${P}.CAN-2004-0075.patch || die "Failed to add the CAN-2004-0075 patch!"
	epatch ${DISTDIR}/${P}-CAN-2004-0415.patch || die "Failed to add the CAN-2004-0415 patch!"
	epatch ${FILESDIR}/${P}.CAN-2004-0685.patch || die "Failed to add the CAN-2004-0685 patch!"
	epatch ${DISTDIR}/${P}-CAN-2004-0814.patch || die "Failed to add the CAN-2004-0814 patch!"
	epatch ${FILESDIR}/${P}.cmdlineLeak.patch || die "Failed to apply the /proc/cmdline patch!"
	epatch ${FILESDIR}/${P}.XDRWrapFix.patch || die "Failed to apply the kNFSd XDR fix!"
	# The munmap() patch is already in aa2...

	kernel_universal_unpack
}
