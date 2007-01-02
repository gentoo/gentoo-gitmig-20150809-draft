# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/kurobox-sources/kurobox-sources-2.4.31.ebuild,v 1.2 2007/01/02 01:46:06 dsd Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
K_SECURITY_UNSUPPORTED="1"
inherit kernel-2 eutils

#TIMESTAMP="20050527"
#[ "${PR}" == "r0" ] && KV=${PV/_/-}-openmosix || KV=${PV/_/-}-openmosix-${PR}
S=${WORKDIR}/linux-${KV}

DESCRIPTION="Full sources for the Linux kernel, including kurobox hardware patches."
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${PV}.tar.bz2
		 mirror://gentoo/kurobox-${PV}.patch.bz2"
PROVIDE="virtual/linux-sources"
HOMEPAGE="http://www.kernel.org/
		http://www.kurobox.com"
LICENSE="GPL-2"
SLOT="${KV}"
KEYWORDS="-* ~ppc"
IUSE=""

src_unpack() {
	unpack linux-${PV}.tar.bz2
	mv linux-${PV} linux-${KV}
	cd linux-${KV}
	epatch ${DISTDIR}/kurobox-${PV}.patch.bz2 || die "kurobox patch failed."
	unpack_2_4
}

pkg_postinst() {
	echo
	einfo "For documentation about setting up your kurobox - check out"
	einfo "http://www.kurobox.com/online/tiki-index.php?page=Welcome"
	einfo "For a more modular and complete kurobox config - check out"
	einfo "http://dev.gentoo.org/~nerdboy/config-2.4.31-kurobox"
	echo
}
