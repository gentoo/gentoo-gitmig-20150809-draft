# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/vserver-sources/vserver-sources-2.4.26.1.28-r2.ebuild,v 1.1 2004/08/05 11:47:55 plasmaroo Exp $

ETYPE="sources"
inherit kernel eutils
OKV=2.4.26
KV=2.4.26

## idea: after the kernel-version (2.4.26) we append the vs-version (e.g. 1.3.9) to
## get 2.4.25.1.3.9 that is globbed out here:
VEXTRAVERSION="-vs${PV#*.*.*.}"
EXTRAVERSION="-vs${PV#*.*.*.}-${PR}"

S=${WORKDIR}/linux-${KV}
# What's in this kernel?

# INCLUDED:
# stock 2.4.26 kernel sources (or newer)
# devel-version of vsever-patch: 1.3.9 (or newer)

DESCRIPTION="Linux kernel with DEVEL version ctx-/vserver-patch"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	http://www.13thfloor.at/vserver/s_release/${VEXTRAVERSION/-vs/v}/linux-vserver-${VEXTRAVERSION/-vs/}.tar.bz2
	http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/linux-${OKV}-CAN-2004-0415.patch"
HOMEPAGE="http://www.kernel.org/ http://www.13thfloor.at/vserver/ http://www.linux-vserver.org/"

KEYWORDS="~x86 -ppc"
IUSE=""
SLOT="${KV}"

src_unpack() {
	unpack linux-${OKV}.tar.bz2
	cd ${WORKDIR}
	mv linux-${OKV} linux-${KV}${VEXTRAVERSION}-${PR}

	echo ${DISTDIR}/linux-vserver-${VEXTRAVERSION/-vs/}.tar.bz2
	tar xvjf ${DISTDIR}/linux-vserver-${VEXTRAVERSION/-vs/}.tar.bz2 || die "Unpacking patch failed!"

	cd linux-${KV}${VEXTRAVERSION}-${PR}
	epatch ${WORKDIR}/patch-${KV}${VEXTRAVERSION}.diff
	epatch ${FILESDIR}/${PN}-2.4.26.1.3.9.CAN-2004-0394.patch || die "Failed to add the CAN-2004-0394 patch!"
	epatch ${DISTDIR}/linux-${OKV}-CAN-2004-0415.patch || die "Failed to add the CAN-2004-0415 patch!"
	epatch ${FILESDIR}/${PN}-2.4.26.1.3.9.CAN-2004-0495.patch || die "Failed to add the CAN-2004-0495 patch!"
	epatch ${FILESDIR}/${PN}-2.4.26.1.3.9.CAN-2004-0497.patch || die "Failed to add the CAN-2004-0497 patch!"
	epatch ${FILESDIR}/${PN}-2.4.26.1.3.9.CAN-2004-0535.patch || die "Failed to add the CAN-2004-0535 patch!"
	epatch ${FILESDIR}/${PN}-2.4.26.1.3.9.FPULockup-53804.patch || die "Failed to apply FPU-lockup patch!"
	kernel_universal_unpack
}
