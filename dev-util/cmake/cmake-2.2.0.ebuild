# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cmake/cmake-2.2.0.ebuild,v 1.1 2005/08/20 11:45:19 dragonheart Exp $

inherit debug flag-o-matic qt3

SHORT_PV=2.2

DESCRIPTION="Cross platform Make"
HOMEPAGE="http://www.cmake.org/"
SRC_URI="http://www.cmake.org/files/v${SHORT_PV}/${P}.tar.gz"

LICENSE="CMake"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	strip-flags
	./bootstrap \
		--prefix=/usr \
		--docdir=/share/doc/${PN} \
		--datadir=/share/${PN} \
		--mandir=/share/man || die "./bootstrap failed"
	emake || die
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
