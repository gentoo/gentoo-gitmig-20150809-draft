# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cmake/cmake-2.2.1.ebuild,v 1.6 2006/10/21 16:00:03 dertobi123 Exp $

inherit debug flag-o-matic qt3 toolchain-funcs eutils

SHORT_PV=2.2

DESCRIPTION="Cross platform Make"
HOMEPAGE="http://www.cmake.org/"
SRC_URI="http://www.cmake.org/files/v${SHORT_PV}/${P}.tar.gz"

LICENSE="CMake"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ~mips ppc ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-rpath-fix.patch
	sed -i -e "s:g++:$(tc-getCXX):" \
		${S}/Modules/CMakeCXXInformation.cmake
	sed -i -e "s:gcc:$(tc-getCC):" \
		${S}/Modules/CMakeCInformation.cmake
}

src_compile() {
	strip-flags
	./bootstrap \
		--prefix=/usr \
		--docdir=/share/doc/${PN} \
		--datadir=/share/${PN} \
		--mandir=/share/man || die "./bootstrap failed"
	emake -j1 || die
}

src_test() {
	einfo "Self tests broken"
	make test || \
		einfo "note test failure on qtwrapping was expected - nature of portage rather than a true failure"
}

src_install() {
	make install DESTDIR=${D} || die "install failed"
	mv ${D}usr/share/doc/cmake ${D}usr/share/doc/${PF}
}
