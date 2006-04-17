# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/openmosix-sources/openmosix-sources-2.4.32.ebuild,v 1.1 2006/04/17 21:28:20 voxus Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
inherit kernel-2 eutils

TIMESTAMP="20060417"
[ "${PR}" == "r0" ] && KV=${PV/_/-}-openmosix || KV=${PV/_/-}-openmosix-${PR}
S=${WORKDIR}/linux-${KV}

DESCRIPTION="Full sources for the Gentoo openMosix Linux kernel, including shared memory migration patch (migshm)"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${PV}.tar.bz2
		http://dev.gentoo.org/~voxus/om/patch-${PV}-om-migshm-no-mfs-${TIMESTAMP}.bz2"
PROVIDE="virtual/linux-sources"
HOMEPAGE="http://www.kernel.org/
		http://www.openmosix.org/
		http://openmosix.snarc.org/
		http://dev.gentoo.org/~voxus/om/"
LICENSE="GPL-2"
SLOT="${KV}"
KEYWORDS="-* ~x86"
IUSE=""

src_unpack() {
	unpack linux-${PV}.tar.bz2
	mv linux-${PV} linux-${KV}
	cd linux-${KV}
	epatch ${DISTDIR}/patch-${PV}-om-migshm-no-mfs-${TIMESTAMP}.bz2 || die "openMosix patch failed."

	unpack_2_4
}

pkg_postinst() {
	echo
	ewarn "Please, note that MFS and DFSA support is now Officially dropped."
	echo
	einfo "For documentation about setting up your cluster - consider look at"
	einfo "http://www.gentoo.org/doc/en/openmosix-howto.xml"
	echo
}
