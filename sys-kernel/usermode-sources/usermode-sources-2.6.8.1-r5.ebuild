# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/usermode-sources/usermode-sources-2.6.8.1-r5.ebuild,v 1.2 2004/11/28 11:50:35 plasmaroo Exp $

K_NOUSENAME="yes"
ETYPE="sources"
inherit kernel-2
detect_version

UML_PATCH="uml-patch-${PV}-1"

UNIPATCH_LIST="${DISTDIR}/${UML_PATCH}.bz2
	${DISTDIR}/linux-${PV}-CAN-2004-0814.patch
	${FILESDIR}/${PN}-2.6.cmdlineLeak.patch
	${FILESDIR}/${PN}-2.6.devPtmx.patch
	${FILESDIR}/${PN}-2.6.binfmt_elf.patch
	${FILESDIR}/${PN}-2.6.smbfs.patch
	${FILESDIR}/${PN}-2.6.binfmt_a.out.patch
	${FILESDIR}/${PN}-2.6.AF_UNIX.patch"

DESCRIPTION="Full (vanilla) sources for the User Mode Linux kernel"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${PV}.tar.bz2
	mirror://sourceforge/user-mode-linux/${UML_PATCH}.bz2
	http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/linux-${PV}-CAN-2004-0814.patch"
HOMEPAGE="http://www.kernel.org/ http://user-mode-linux.sourceforge.net"
KEYWORDS="~x86"
RESTRICT="nomirror"
IUSE=""

