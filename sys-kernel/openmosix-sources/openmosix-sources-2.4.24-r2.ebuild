# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/openmosix-sources/openmosix-sources-2.4.24-r2.ebuild,v 1.3 2004/08/09 13:17:31 voxus Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
inherit kernel eutils

OKV="2.4.24"
OMV="om1"
[ "${PR}" == "r0" ] && KV=${PV/_/-}-openmosix || KV=${PV/_/-}-openmosix-${PR}
EXTRAVERSION="`echo ${KV}|sed -e 's:[0-9]\+\.[0-9]\+\.[0-9]\+\(.*\):\1:'`"
BASE="`echo ${KV}|sed -e s:${EXTRAVERSION}::`"
S=${WORKDIR}/linux-${KV}

# What's in this kernel?

# INCLUDED:
#   2.4.22, plus:
#   2.4.22  openmosix-2.4.22-3
#			various security patches

DESCRIPTION="Full sources for the Gentoo openMosix Linux kernel"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
mirror://sourceforge/openmosix/openMosix-${OKV}-${OMV}.bz2
http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/linux-2.4.23-CAN-2004-0415.patch"
PROVIDE="virtual/linux-sources"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/ http://www.openmosix.org/"
LICENSE="GPL-2"
SLOT="${KV}"
KEYWORDS="-* x86"
IUSE=""

src_unpack() {
	unpack linux-${OKV}.tar.bz2
	mv linux-${OKV} linux-${KV} || die
	cd linux-${KV}

	epatch ${DISTDIR}/openMosix-${OKV}-${OMV}.bz2 || die "openMosix patch failed"

	epatch ${FILESDIR}/openmosix-sources.CAN-2003-0985.patch || die "Security patch failed"
	epatch ${FILESDIR}/openmosix-sources.CAN-2004-0001.patch || die "Security patch failed"
	epatch ${FILESDIR}/openmosix-sources.CAN-2004-0010.patch || die "Security patch failed"
	epatch ${FILESDIR}/openmosix-sources.CAN-2004-0109.patch || die "Security patch failed"
	epatch ${FILESDIR}/openmosix-sources.CAN-2004-0177.patch || die "Security patch failed"
	epatch ${FILESDIR}/openmosix-sources.CAN-2004-0178.patch || die "Security patch failed"
	epatch ${FILESDIR}/openmosix-sources.CAN-2004-0181.patch || die "Security patch failed"
	epatch ${FILESDIR}/openmosix-sources.CAN-2004-0495.patch || die "Security patch failed"
	epatch ${FILESDIR}/openmosix-sources.CAN-2004-0497.patch || die "Security patch failed"
	epatch ${FILESDIR}/openmosix-sources.CAN-2004-0535.patch || die "Security patch failed"

	epatch ${DISTDIR}/linux-2.4.23-CAN-2004-0415.patch || die "Failed to add CAN-2004-0415"

	kernel_universal_unpack
}

pkg_postinst() {
	[ "$ETYPE" = "headers" ] && return
	if [ ! -e ${ROOT}usr/src/linux ]
	then
		rm -f ${ROOT}usr/src/linux
		ln -sf linux-${KV} ${ROOT}/usr/src/linux
	fi
}
