# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/openmosix-sources/openmosix-sources-2.4.26-r5.ebuild,v 1.1 2004/07/22 12:10:12 voxus Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
inherit kernel eutils

OKV="2.4.26"
TIMESTAMP="20040722"
[ "${PR}" == "r0" ] && KV=${PV/_/-}-openmosix || KV=${PV/_/-}-openmosix-${PR}
EXTRAVERSION="`echo ${KV}|sed -e 's:[0-9]\+\.[0-9]\+\.[0-9]\+\(.*\):\1:'`"
BASE="`echo ${KV}|sed -e s:${EXTRAVERSION}::`"
S=${WORKDIR}/linux-${KV}

# What's in this kernel?

# INCLUDED:
#   ${OKV}, plus:
#   ${OKV}  openmosix-migshm-${OKV}-${TIMESTAMP} by voxus

DESCRIPTION="Full sources for the Gentoo openMosix Linux kernel"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2 http://dev.gentoo.org/~voxus/patch-${OKV}-om-migshm-${TIMESTAMP}.bz2"
PROVIDE="virtual/linux-sources"
HOMEPAGE="http://www.kernel.org/ http://www.openmosix.org/ http://dev.gentoo.org/~voxus/om/"
LICENSE="GPL-2"
SLOT="${KV}"
KEYWORDS="-*"
IUSE=""

src_unpack() {
	unpack linux-${OKV}.tar.bz2
	mv linux-${OKV} linux-${KV} || die
	cd linux-${KV}
	epatch ${DISTDIR}/patch-${OKV}-om-migshm-${TIMESTAMP}.bz2 || die "openMosix patch failed."
	kernel_universal_unpack
}
