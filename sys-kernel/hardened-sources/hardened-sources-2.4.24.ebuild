# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hardened-sources/hardened-sources-2.4.24.ebuild,v 1.1 2004/02/07 02:43:20 scox Exp $

IUSE="selinux"

ETYPE="sources"

inherit kernel || die

OKV="`echo ${PV}|sed -e 's:^\([0-9]\+\.[0-9]\+\.[0-9]\+\).*:\1:'`"
EXTRAVERSION="-${PN/-*/}"
KV=${OKV}${EXTRAVERSION}

S=${WORKDIR}/linux-${KV}

DESCRIPTION="Special Security Hardened Gentoo Linux Kernel"

BASE_URI="http://dev.gentoo.org/~scox/kernels/v2.4"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	${BASE_URI}/hardened-sources-${OKV}-base.patch.bz2
	selinux?  ( ${BASE_URI}/hardened-sources-${OKV}-selinux.patch.bz2 )
	!selinux? ( ${BASE_URI}/hardened-sources-${OKV}-grsec.patch.bz2 )"


HOMEPAGE="http://www.gentoo.org/proj/en/hardened/"
KEYWORDS="~x86"
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

	kernel_src_unpack

	cd ${S}
}

pkg_postinst() {
	einfo "This kernel contains LSM/SElinux or GRSecurity"
	einfo "Also included are various other security related patches."
	echo
	einfo "If there are issues with this kernel, search http://bugs.gentoo.org/ for an"
	einfo "existing bug. Only create a new bug if you have not found one that matches"
	einfo "your issue. Please assign your bugs to scox@gentoo.org."
}
