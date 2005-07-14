# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/openmosix-sources/openmosix-sources-2.4.26-r1.ebuild,v 1.4 2005/07/14 18:32:16 voxus Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
inherit kernel-2 eutils

[ "${PR}" == "r0" ] && KV=${PV/_/-}-openmosix || KV=${PV/_/-}-openmosix-${PR}
S=${WORKDIR}/linux-${KV}

DESCRIPTION="Full sources for the Gentoo openMosix Linux kernel"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${PV}.tar.bz2
		mirror://sourceforge/openmosix/openMosix-2.4.26-1.bz2"
PROVIDE="virtual/linux-sources"
HOMEPAGE="http://www.kernel.org/
		http://www.openmosix.org/"
LICENSE="GPL-2"
SLOT="${KV}"
KEYWORDS="-* ~x86"
IUSE=""

src_unpack() {
	unpack linux-${PV}.tar.bz2
	mv linux-${PV} linux-${KV}
	cd linux-${KV}
	epatch ${DISTDIR}/openMosix-${PV}-${PR/r/}.bz2 || die "openMosix patch failed."

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
