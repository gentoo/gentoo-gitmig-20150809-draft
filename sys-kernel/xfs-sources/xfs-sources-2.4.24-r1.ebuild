# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/xfs-sources/xfs-sources-2.4.24-r1.ebuild,v 1.2 2004/02/12 12:53:22 livewire Exp $

ETYPE="sources"

inherit kernel
OKV="`echo ${PV}|sed -e 's:^\([0-9]\+\.[0-9]\+\.[0-9]\+\).*:\1:'`"
EXTRAVERSION="-${PN/-*/}-${PR}"
KV=${OKV}${EXTRAVERSION}

S=${WORKDIR}/linux-${KV}

# Documentation on the patches contained in this kernel will be installed
# to /usr/share/doc/xfs-sources-${PV}/patches.txt.gz

DESCRIPTION="Full sources for the XFS Specialized Gentoo Linux kernel"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	http://dev.gentoo.org/~scox/kernels/v2.4/xfs-sources-${PV}-r1.patch.bz2"

KEYWORDS="x86 -ppc -sparc "
SLOT="${KV}"

src_unpack() {

	unpack ${A}
	mv linux-${OKV} linux-${KV} || die

	cd linux-${KV}

	bzcat ${DISTDIR}/xfs-sources-${PV}-r1.patch.bz2 | patch -p1 \
		|| die "Failed to patch kernel"

	cd ${S}

	make mrproper || die "make mrproper failed"
	kernel_universal_unpack

}

