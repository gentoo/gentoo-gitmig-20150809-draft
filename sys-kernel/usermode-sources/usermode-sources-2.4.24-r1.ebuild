# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/usermode-sources/usermode-sources-2.4.24-r1.ebuild,v 1.1 2004/02/18 18:48:56 iggy Exp $

ETYPE="sources"
inherit kernel eutils

UML_PATCH="uml-patch-2.4.24-1"

# we patch against vanilla-sources only
DESCRIPTION="Full (vanilla) sources for the User Mode Linux kernel"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${PV}.tar.bz2
	mirror://sourceforge/user-mode-linux/${UML_PATCH}.bz2"
HOMEPAGE="http://www.kernel.org/ http://user-mode-linux.sourceforge.net"
LICENSE="GPL-2"
SLOT="${PV}"
KEYWORDS="x86"
EXTRAVERSION=${PR}
RESTRICT="nomirror"

# console-tools is needed to solve the loadkeys fiasco.
# binutils version needed to avoid Athlon/PIII/SSE assembler bugs.
DEPEND=">=sys-devel/binutils-2.11.90.0.31 dev-lang/perl"
RDEPEND=">=sys-libs/ncurses-5.2"

S=${WORKDIR}/linux-${PV}

src_unpack() {
	# unpack vanilla sources
	cd ${WORKDIR}
	unpack linux-${PV}.tar.bz2

	# apply usermode patch
	cd ${S}
	epatch ${DISTDIR}/${UML_PATCH}.bz2
	epatch ${FILESDIR}/${P}.munmap.patch || die "failed to apply munmap patch"

	#epatch ${FILESDIR}/${PN}.CAN-2003-0985.patch || die "Failed to patch mremap() vulnerability!"
	#epatch ${FILESDIR}/${PN}-2.4.22.rtc_fix.patch || die "Failed to patch RTC vulnerabilities!"

	kernel_universal_unpack
}

src_compile() {
	true
}

src_install() {
	mkdir -p ${D}/usr/src/uml

	# fix silly permissions in tarball
	cd ${WORKDIR}
	chown -R root:root *
	chmod -R a+r-w+X,u+w *

	mv linux-${PV} ${D}/usr/src/uml/
}

pkg_postinst() {
	# create linux symlink
	if [ ! -e ${ROOT}usr/src/uml/linux ]
	then
		rm -f ${ROOT}usr/src/uml/linux
		ln -sf ${ROOT}usr/src/uml/linux-${PV} ${ROOT}usr/src/uml/linux
	fi
}
