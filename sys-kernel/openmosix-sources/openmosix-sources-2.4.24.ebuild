# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/openmosix-sources/openmosix-sources-2.4.24.ebuild,v 1.1 2004/01/18 19:57:09 tantive Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
inherit kernel

OKV="2.4.24"
[ "${PR}" == "r0" ] && KV=${PV/_/-}-openmosix || KV=${PV/_/-}-openmosix-${PR}
EXTRAVERSION="`echo ${KV}|sed -e 's:[0-9]\+\.[0-9]\+\.[0-9]\+\(.*\):\1:'`"
BASE="`echo ${KV}|sed -e s:${EXTRAVERSION}::`"
S=${WORKDIR}/linux-${KV}

# What's in this kernel?

# INCLUDED:
#   2.4.24, plus:
#   2.4.24  openmosix-2.4.24-20040116 by tab

DESCRIPTION="Full sources for the Gentoo openMosix Linux kernel"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
http://tab.tuxfamily.org/download/openmosix/stable/patch-2.4.24-om-20040116.bz2"
PROVIDE="virtual/linux-sources"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/ http://www.openmosix.org/"
LICENSE="GPL-2"
SLOT="${KV}"
KEYWORDS="-* ~x86"

src_unpack() {

	unpack linux-${OKV}.tar.bz2
	mv linux-${OKV} linux-${KV} || die
	cd linux-${KV}
	bzcat ${DISTDIR}/patch-2.4.24-om-20040116.bz2|patch -p1 || die "-openmosix patch failed"

	kernel_universal_unpack

}
