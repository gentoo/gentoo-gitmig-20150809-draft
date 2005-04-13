# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/usermode-sources/usermode-sources-2.4.27.ebuild,v 1.1 2005/04/13 15:10:37 johnm Exp $

ETYPE="sources"
inherit kernel-2
detect_version

EXTRAVERSION="${EXTRAVERSION/usermode/uml1}"
KV_FULL="${KV_FULL/usermode/uml1}"

UML_PATCH="uml-patch-${OKV}-1"

DESCRIPTION="Full (vanilla) sources for the User Mode Linux kernel"
SRC_URI="${KERNEL_URI} mirror://sourceforge/user-mode-linux/${UML_PATCH}.bz2"
HOMEPAGE="http://www.kernel.org/ http://user-mode-linux.sourceforge.net"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc"
RESTRICT="nomirror"

UNIPATCH_LIST="${DISTDIR}/${UML_PATCH}.bz2
	${FILESDIR}/${P}.CAN-2004-1295.patch
	${FILESDIR}/${PN}-2.4.cmdlineLeak.patch
	${FILESDIR}/${PN}-2.4.XDRWrapFix.patch
	${FILESDIR}/${PN}-2.4.binfmt_elf.patch
	${FILESDIR}/${PN}-2.4.smbfs.patch
	${FILESDIR}/${PN}-2.4.binfmt_a.out.patch
	${FILESDIR}/${PN}.AF_UNIX.patch
	${FILESDIR}/${PN}-2.4.vma.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-1016.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-1056.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-1137.patch
	${FILESDIR}/${PN}-2.4.brk-locked.patch
	${FILESDIR}/${PN}-2.4.77094.patch
	${FILESDIR}/${PN}-2.4.77666.patch
	${FILESDIR}/${PN}-2.4.78362.patch
	${FILESDIR}/${PN}-2.4.78363.patch"

K_EXTRAEINFO="Since you are using UML, you may want to read the Gentoo Linux
Developer's guide to system testing with User-Mode Linux that
can be fount at http://www.gentoo.org/doc/en/uml.xml"

src_install() {
	kernel-2_src_install
	mkdir -p ${D}/usr/src/uml
	mv ${D}/usr/src/linux-${KV_FULL} ${D}/usr/src/uml/
}
