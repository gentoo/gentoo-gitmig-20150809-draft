# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cmake/cmake-2.0.3.ebuild,v 1.2 2004/11/24 21:51:16 sekretarz Exp $

inherit debug flag-o-matic

SHORT_PV=2.0

DESCRIPTION="Cross platform Make"
HOMEPAGE="http://www.cmake.org/"
SRC_URI="http://www.cmake.org/files/v${SHORT_PV}/${P}.tar.gz"

LICENSE="CMake"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"
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

src_install() {
	make install DESTDIR=${D} || die "install failed"
}
