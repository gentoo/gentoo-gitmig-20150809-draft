# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/xbox-sources/xbox-sources-2.6.8.1-r3.ebuild,v 1.1 2004/11/12 20:38:36 plasmaroo Exp $

ETYPE='sources'
inherit kernel-2
detect_version

# version of gentoo patchset
XBOX_PATCHES=xboxpatches-2.6.8.1-20041104.tar.bz2

K_NOSETEXTRAVERSION="don't_set_it"
KEYWORDS="~x86 -*"
UNIPATCH_LIST="
	${DISTDIR}/${XBOX_PATCHES}
	${DISTDIR}/linux-${OKV}-CAN-2004-0814.patch
	${FILESDIR}/${PN}-2.6.7.cmdlineLeak.patch
	${FILESDIR}/${P}.devPtmx.patch
	${FILESDIR}/${P}.binfmt_elf.patch"
DESCRIPTION='Full sources for the Xbox Linux kernel'
SRC_URI="${KERNEL_URI}
	mirror://gentoo/${XBOX_PATCHES}
	http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/linux-${OKV}-CAN-2004-0814.patch"

pkg_postinst() {
	einfo ''
	einfo 'WARNING: The FATX driver is currently horribly broken. Writing to a FATX partition with this kernel will corrupt it.'
	einfo ''
}
