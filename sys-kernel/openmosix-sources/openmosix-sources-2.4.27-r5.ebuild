# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/openmosix-sources/openmosix-sources-2.4.27-r5.ebuild,v 1.1 2004/11/25 14:59:37 voxus Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
inherit kernel eutils

OKV="2.4.27"
TIMESTAMP="20040914"
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
		http://dev.gentoo.org/~voxus/om/"
LICENSE="GPL-2"
SLOT="${KV}"
KEYWORDS="-*"
IUSE=""

src_unpack() {
	unpack linux-${OKV}.tar.bz2
	mv linux-${OKV} linux-${KV} || die
	cd linux-${KV}
	epatch ${DISTDIR}/patch-${OKV}-om-migshm-${TIMESTAMP}.bz2 || die "openMosix patch failed."
	epatch ${DISTDIR}/linux-${PV}-CAN-2004-0814.patch || die "security patch for CAN-2004-0814 failed."
	epatch ${FILESDIR}/${PN}.CAN-2004-0841-fix_ldisc_switch.patch || die "fix for CAN-2004-0814 patch failed."
	epatch ${DISTDIR}/linux-${PV}-nfs3-xdr.patch.bz2 || die "security patch for nfs3-xdk failed."
	epatch ${FILESDIR}/${PN}-binfmt_elf.patch || die "Security patch for binfmt_elf failed."
	epatch ${FILESDIR}/${PN}-${PV}-smbfs.patch
	kernel_universal_unpack
}
