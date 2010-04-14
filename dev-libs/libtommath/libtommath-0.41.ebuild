# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtommath/libtommath-0.41.ebuild,v 1.5 2010/04/14 20:09:52 jer Exp $

EAPI=3

inherit eutils multilib

DESCRIPTION="highly optimized and portable routines for integer based number theoretic applications"
HOMEPAGE="http://www.libtom.org/"
SRC_URI="http://www.libtom.org/files/ltm-${PV}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

DEPEND="sys-devel/libtool"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-LDFLAGS.patch
	epatch "${FILESDIR}"/${P}-CC.patch

	[[ ${CHOST} == *-darwin* ]] && \
		sed -i -e 's/libtool/glibtool/g' makefile.shared

	sed -i -e 's: -g $(GROUP) -o $(USER)::g' makefile.shared
}

src_compile() {
	emake CC=$(tc-getCC) -f makefile.shared IGNORE_SPEED=1 LIBPATH="${EPREFIX}/usr/$(get_libdir)" || die "emake failed"
}

src_install() {
	emake -f makefile.shared install DESTDIR="${D}" LIBPATH="${EPREFIX}/usr/$(get_libdir)" INCPATH="${EPREFIX}/usr/include" || die
	dodoc changes.txt *.pdf
	docinto demo ; dodoc demo/*.c
}
