# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/xbox-sources/xbox-sources-2.6.7-r4.ebuild,v 1.1 2004/08/05 12:17:09 plasmaroo Exp $

ETYPE='sources'
inherit kernel-2
detect_version

#version of gentoo patchset
XPV=7.20040629
XBOX_PATCHES=xboxpatches-${KV_MAJOR}.${KV_MINOR}-${XPV}.tar.bz2

K_NOSETEXTRAVERSION="don't_set_it"
KEYWORDS="~x86 -*"
UNIPATCH_LIST="
	${DISTDIR}/${XBOX_PATCHES}
	${DISTDIR}/linux-${OKV}-CAN-2004-0415.patch
	${FILESDIR}/${PN}.CAN-2004-0497.patch
	${FILESDIR}/${PN}.IPTables-RDoS.patch
	${FILESDIR}/${PN}.ProcPerms.patch
	${FILESDIR}/${P}.CAN-2004-0596.patch"
DESCRIPTION='Full sources for the Xbox Linux kernel'
SRC_URI="${KERNEL_URI}
	mirror://gentoo/${XBOX_PATCHES}
	http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/linux-${OKV}-CAN-2004-0415.patch"

pkg_postinst() {
	einfo ''
	einfo 'WARNING: The FATX driver is currently horribly broken. Writing to a FATX partition with this kernel will corrupt it.'
	einfo ''
}
