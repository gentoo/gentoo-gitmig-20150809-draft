# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/xbox-sources/xbox-sources-2.6.10-r2.ebuild,v 1.1 2005/03/26 20:28:36 plasmaroo Exp $

ETYPE='sources'
inherit kernel-2
detect_version

# version of gentoo patchset
XBOX_PATCHES=xboxpatches-2.6.10-20050102.tar.bz2

K_NOSETEXTRAVERSION="don't_set_it"
KEYWORDS="~x86 -*"
UNIPATCH_LIST="
	${DISTDIR}/${XBOX_PATCHES}
	${FILESDIR}/${PN}-2.6.8.1.CAN-2004-1056.patch
	${FILESDIR}/${P}.smbfs.patch
	${FILESDIR}/${P}.75963.patch
	${FILESDIR}/${P}.brk-locked.patch
	${FILESDIR}/${P}.77094.patch
	${FILESDIR}/${P}.74070.patch
	${FILESDIR}/${P}.77666.patch
	${FILESDIR}/${P}.77923.patch
	${FILESDIR}/${P}.81106.patch
	${FILESDIR}/${P}.82141.patch"
DESCRIPTION='Full sources for the Xbox Linux kernel'
SRC_URI="${KERNEL_URI}
	mirror://gentoo/${XBOX_PATCHES}"

pkg_postinst() {
	einfo ''
	einfo 'WARNING: The FATX driver is currently horribly broken. Writing to a FATX partition with this kernel will corrupt it.'
	einfo ''
}
