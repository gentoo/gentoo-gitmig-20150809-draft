# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/openmosix-sources/openmosix-sources-2.4.22_rc2.ebuild,v 1.2 2003/09/07 07:26:01 msterret Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

OKV="2.4.21"
[ "${PR}" == "r0" ] && KV=${PV/_/-}-openmosix || KV=${PV/_/-}-openmosix-${PR}
EXTRAVERSION="`echo ${KV}|sed -e 's:[0-9]\+\.[0-9]\+\.[0-9]\+\(.*\):\1:'`"
BASE="`echo ${KV}|sed -e s:${EXTRAVERSION}::`"
S=${WORKDIR}/linux-${KV}

ETYPE="sources"
inherit kernel || die

# What's in this kernel?

# INCLUDED:
#   2.4.22-rc2, plus:
#   2.4.22-rc2  openmosix-2.4.22-rc2-20030811

DESCRIPTION="Full sources for the Gentoo openMosix Linux kernel"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
http://www.kernel.org/pub/linux/kernel/v2.4/testing/patch-${PV/_/-}.bz2
http://tab.tuxfamily.org/download/openmosix/patch-2.4.22-rc2-om-20030811.bz2"
PROVIDE="virtual/linux-sources"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/ http://www.openmosix.org/"
LICENSE="GPL-2"
SLOT="${KV}"
KEYWORDS="~x86 -ppc -sparc -alpha"

src_unpack() {
	unpack linux-${OKV}.tar.bz2
	mv linux-${OKV} linux-${KV} || die
	cd linux-${KV}
	bzcat ${DISTDIR}/patch-${PV/_/-}.bz2|patch -p1 || die "-marcelo patch failed"
	bzcat ${DISTDIR}/patch-2.4.22-rc2-om-20030811.bz2|patch -p1 || die "-openmosix patch failed"

	kernel_universal_unpack
}
