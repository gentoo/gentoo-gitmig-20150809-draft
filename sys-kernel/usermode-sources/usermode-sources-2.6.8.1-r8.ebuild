# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/usermode-sources/usermode-sources-2.6.8.1-r8.ebuild,v 1.1 2005/01/09 12:22:41 plasmaroo Exp $

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
	${FILESDIR}/${PN}-2.6.AF_UNIX.patch
	${FILESDIR}/${PN}-2.6.AF_UNIX.SELinux.patch
	${FILESDIR}/${PN}-2.6.vma.patch
	${FILESDIR}/${PN}-2.6.CAN-2004-1016.patch
	${FILESDIR}/${PN}-2.6.CAN-2004-1056.patch
	${FILESDIR}/${PN}-2.6.CAN-2004-1137.patch
	${FILESDIR}/${PN}-2.6.CAN-2004-1151.patch
	${FILESDIR}/${PN}-2.6.75963.patch
	${FILESDIR}/${PN}-2.6.brk-locked.patch
	${FILESDIR}/${PN}-2.6.77094.patch"

DESCRIPTION="Full (vanilla) sources for the User Mode Linux kernel"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${PV}.tar.bz2
	mirror://sourceforge/user-mode-linux/${UML_PATCH}.bz2
	http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/linux-${PV}-CAN-2004-0814.patch"
HOMEPAGE="http://www.kernel.org/ http://user-mode-linux.sourceforge.net"
KEYWORDS="~x86"
RESTRICT="nomirror"
IUSE=""

