# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hardened-sources/hardened-sources-2.4.24-r3.ebuild,v 1.2 2004/05/30 23:53:42 pvdabeel Exp $

IUSE="selinux"
ETYPE="sources"

inherit kernel eutils

OKV="`echo ${PV}|sed -e 's:^\([0-9]\+\.[0-9]\+\.[0-9]\+\).*:\1:'`"
EXTRAVERSION="-${PN/-*/}-${PR}"
KV=${OKV}${EXTRAVERSION}

S=${WORKDIR}/linux-${KV}
DESCRIPTION="Special Security Hardened Gentoo Linux Kernel"

BASE_URI="http://dev.gentoo.org/~scox/kernels/v2.4"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	${BASE_URI}/hardened-sources-${OKV}-base.patch.bz2
	selinux? ( ${BASE_URI}/hardened-sources-${OKV}-selinux.patch.bz2 )
	!selinux? ( ${BASE_URI}/hardened-sources-${OKV}-grsec.patch.bz2 )"

HOMEPAGE="http://www.gentoo.org/proj/en/hardened/"
KEYWORDS="x86 -ppc"
SLOT="${KV}"

src_unpack() {
	unpack ${A}

	mv linux-${OKV} linux-${KV} || die
	cd linux-${KV}

	bzcat ${DISTDIR}/hardened-sources-${OKV}-base.patch.bz2 | patch -p1
	if [ "`use selinux`" ]; then
		bzcat ${DISTDIR}/hardened-sources-${OKV}-selinux.patch.bz2 | patch -p1
	else
		bzcat ${DISTDIR}/hardened-sources-${OKV}-grsec.patch.bz2 | patch -p1
	fi

	epatch ${FILESDIR}/${P}.munmap.patch || die "Failed to apply munmap patch!"
	epatch ${FILESDIR}/${P}.CAN-2004-0010.patch || die "Failed to add the CAN-2004-0010 patch!"
	epatch ${FILESDIR}/${P}.CAN-2004-0109.patch || die "Failed to patch CAN-2004-0109 vulnerability!"
	epatch ${FILESDIR}/${P}.CAN-2004-0177.patch || die "Failed to add the CAN-2004-0177 patch!"
	epatch ${FILESDIR}/${P}.CAN-2004-0178.patch || die "Failed to add the CAN-2004-0178 patch!"
	kernel_src_unpack
}

pkg_postinst() {
	einfo "This kernel contains LSM/SElinux or GRSecurity"
	einfo "Also included are various other security related patches."
	echo
	einfo "If there are issues with this kernel, search http://bugs.gentoo.org/ for an"
	einfo "existing bug. Only create a new bug if you have not found one that matches"
	einfo "your issue. Please assign your bugs to scox@gentoo.org."
}
