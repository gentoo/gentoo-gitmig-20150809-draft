# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/usermode-sources/usermode-sources-2.4.26-r10.ebuild,v 1.1 2004/11/27 20:04:10 plasmaroo Exp $

ETYPE="sources"
inherit kernel-2
detect_version

EXTRAVERSION="${EXTRAVERSION/usermode/uml1}"
KV_FULL="${KV_FULL/usermode/uml1}"

UML_PATCH="uml-patch-${PV}-3"

DESCRIPTION="Full (vanilla) sources for the User Mode Linux kernel"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${PV}.tar.bz2
	mirror://sourceforge/user-mode-linux/${UML_PATCH}.bz2
	http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/linux-${PV}-CAN-2004-0415.patch
	http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/${P}-CAN-2004-0814.patch"
HOMEPAGE="http://www.kernel.org/ http://user-mode-linux.sourceforge.net"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc"
IUSE=""
RESTRICT="nomirror"

# console-tools is needed to solve the loadkeys fiasco.
# binutils version needed to avoid Athlon/PIII/SSE assembler bugs.
DEPEND="${DEPEND} >=sys-devel/binutils-2.11.90.0.31 dev-lang/perl"
RDEPEND="${RDEPEND} >=sys-libs/ncurses-5.2"

UNIPATCH_LIST="${DISTDIR}/${UML_PATCH}.bz2
	${FILESDIR}/${P}.CAN-2004-0394.patch
	${DISTDIR}/linux-${PV}-CAN-2004-0415.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0495.patch
	${FILESDIR}/${PN}.CAN-2004-0497.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0535.patch
	${FILESDIR}/${PN}-2.4.CAN-2004-0685.patch
	${DISTDIR}/${P}-CAN-2004-0814.patch
	${FILESDIR}/${PN}-2.4.FPULockup-53804.patch
	${FILESDIR}/${PN}-2.4.cmdlineLeak.patch
	${FILESDIR}/${PN}-2.4.XDRWrapFix.patch
	${FILESDIR}/${PN}-2.4.binfmt_elf.patch
	${FILESDIR}/${PN}-2.4.smbfs.patch
	${FILESDIR}/${PN}-2.4.binfmt_a.out.patch
	${FILESDIR}/${PN}.AF_UNIX.patch"

src_install() {
	kernel-2_src_install
	mkdir -p ${D}/usr/src/uml
	mv ${D}/usr/src/linux-${KV_FULL} ${D}/usr/src/uml/
}
