# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cmake/cmake-1.8.2.ebuild,v 1.1 2004/01/09 19:41:25 lisa Exp $

inherit debug flag-o-matic
strip-flags

SHORT_PV=1.8

DESCRIPTION="Cross platform Make"
HOMEPAGE="http://www.cmake.org/"
SRC_URI="http://www.cmake.org/files/v${SHORT_PV}/${P}.tar.gz"
LICENSE="CMake"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""

DEPEND="sys-libs/glibc"

S=${WORKDIR}/${P}

src_compile() {
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
