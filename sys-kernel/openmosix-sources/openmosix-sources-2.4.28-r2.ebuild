# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/openmosix-sources/openmosix-sources-2.4.28-r2.ebuild,v 1.2 2004/12/09 09:57:55 voxus Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
inherit kernel eutils

OKV="2.4.28"
TIMESTAMP="20041206"
[ "${PR}" == "r0" ] && KV=${PV/_/-}-openmosix || KV=${PV/_/-}-openmosix-${PR}
S=${WORKDIR}/linux-${KV}

# What's in this kernel?

# INCLUDED:
#   ${OKV}, plus:
#   ${OKV}  openmosix-migshm-${OKV}-${TIMESTAMP} by voxus

DESCRIPTION="Full sources for the Gentoo openMosix Linux kernel, including shared memory migration patch (migshm)"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
		http://dev.gentoo.org/~voxus/om/patch-${OKV}-om-migshm-${TIMESTAMP}.bz2
		http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/linux-2.4.27-CAN-2004-0814.patch
		mirror://gentoo/linux-2.4.27-nfs3-xdr.patch.bz2"
PROVIDE="virtual/linux-sources"
HOMEPAGE="http://www.kernel.org/
		http://www.openmosix.org/
		http://openmosix.snarc.org/
		http://dev.gentoo.org/~voxus/om/"
LICENSE="GPL-2"
SLOT="${KV}"
KEYWORDS="-* x86"
IUSE=""

src_unpack() {
	unpack linux-${OKV}.tar.bz2
	mv linux-${OKV} linux-${KV} || die
	cd linux-${KV}
	epatch ${DISTDIR}/patch-${OKV}-om-migshm-${TIMESTAMP}.bz2 || die "openMosix patch failed."
	epatch ${FILESDIR}/${PN}-binfmt_aout.patch || die "Security patch for binfmt_aout failed."
	epatch ${FILESDIR}/${PN}-dn_neigh.patch || ewarn "dn_neigh patch failed."
	kernel_universal_unpack
}
