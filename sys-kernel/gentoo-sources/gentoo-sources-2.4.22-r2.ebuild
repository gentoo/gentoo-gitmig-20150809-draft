# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-sources/gentoo-sources-2.4.22-r2.ebuild,v 1.1 2003/12/21 06:42:32 iggy Exp $

# OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"

inherit kernel
OKV="`echo ${PV}|sed -e 's:^\([0-9]\+\.[0-9]\+\.[0-9]\+\).*:\1:'`"
EXTRAVERSION="-${PN/-*/}"
[ ! "${PR}" == "r0" ] && EXTRAVERSION="${EXTRAVERSION}-${PR}"
KV="${OKV}${EXTRAVERSION}"

S=${WORKDIR}/linux-${KV}

# Documentation on the patches contained in this kernel will be installed
# to /usr/share/doc/gentoo-sources-${PV}/patches.txt.gz

DESCRIPTION="Full sources for the Gentoo Kernel."
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	http://dev.gentoo.org/~iggy/gentoo-sources-${PVR}.patch.bz2"
HOMEPAGE="http://www.gentoo.org/ http://www.kernel.org/"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc -sparc -alpha -hppa -mips -arm ~amd64 ~ia64"
SLOT="${KV}"

src_unpack() {
	unpack ${A}

	mv linux-${OKV} linux-${KV} \
		|| die "Error moving kernel source tree to linux-${KV}"

	cd linux-${KV}

	bzcat ${DISTDIR}/gentoo-sources-${PVR}.patch.bz2 | patch -p1 \
		|| die "Failed to patch kernel, please file a bug at bugs.gentoo.org"

	cd ${S}
	make mrproper || die "make mrproper failed"
	make include/linux/version.h || die "make include/linux/version.h failed"
}

pkg_postinst() {
	kernel_pkg_postinst

	einfo "If there are issues with this kernel, search http://bugs.gentoo.org/ for an"
	einfo "existing bug. Only create a new bug if you have not found one that matches"
	einfo "your issue. It is best to do an advanced search as the initial search has a"
	einfo "very low yield. Please assign your bugs to x86-kernel@gentoo.org."
	echo
	einfo "Please read the ChangeLog and associated docs for more information."
}
