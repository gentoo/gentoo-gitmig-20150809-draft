# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/usermode-sources/usermode-sources-2.4.22-r2.ebuild,v 1.1 2004/01/07 10:15:33 plasmaroo Exp $

ETYPE="sources"
inherit kernel

UML_VERSION="${PV}"
UML_PATCH="uml-patch-2.4.22-5"

S=${WORKDIR}/linux-${PV}

# we patch against vanilla-sources only

DESCRIPTION="Full (vanilla) sources for the User Mode Linux kernel"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${PV}.tar.bz2
mirror://sourceforge/user-mode-linux/${UML_PATCH}.bz2"
HOMEPAGE="http://www.kernel.org/ http://user-mode-linux.sourceforge.net"
LICENSE="GPL-2"
SLOT="${UML_VERSION}"
KEYWORDS="x86 -ppc -sparc -alpha"
EXTRAVERSION=${PR}

#console-tools is needed to solve the loadkeys fiasco.
#binutils version needed to avoid Athlon/PIII/SSE assembler bugs.
DEPEND=">=sys-devel/binutils-2.11.90.0.31 dev-lang/perl"
RDEPEND=">=sys-libs/ncurses-5.2"

src_unpack() {

	cd ${WORKDIR}
	unpack linux-${PV}.tar.bz2
	if [ "${PV}" != "${UML_VERSION}" ]; then
		mv linux-${PV} linux-${UML_VERSION} || die
	fi
	cd ${S}
	bzcat ${DISTDIR}/${UML_PATCH}.bz2 | patch -p1

	epatch ${FILESDIR}/do_brk_fix.patch || die "Failed to patch do_brk() vulnerability!"
	epatch ${FILESDIR}/${PN}.CAN-2003-0985.patch || die "Failed to patch mremap() vulnerability!"
	epatch ${FILESDIR}/${P}.rtc_fix.patch || die "Failed to patch RTC vulnerabilities!"
	kernel_universal_unpack

	echo "Preparing for compilation..."

	# Fix silly permissions in tarball
	cd ${WORKDIR}
	chown -R 0:0 *
	chmod -R a+r-w+X,u+w *

}

src_compile() {
	ewarn "Nothing to compile.  That's up to the user"
}

src_install() {
		mkdir -p ${D}/usr/src/uml
		cd ${WORKDIR}
		mv linux-${UML_VERSION} ${D}/usr/src/uml/
}

pkg_postinst() {
	# create linux symlink
	if [ ! -e ${ROOT}usr/src/uml/linux ]
	then
		rm -f ${ROOT}usr/src/uml/linux
		ln -sf ${ROOT}usr/src/uml/linux-${PV} ${ROOT}usr/src/uml/linux
	fi
}
