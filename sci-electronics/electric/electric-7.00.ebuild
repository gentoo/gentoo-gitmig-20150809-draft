# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/electric/electric-7.00.ebuild,v 1.14 2009/09/23 20:00:10 patrick Exp $

EAPI=1

inherit eutils qt3

IUSE="qt3"

DESCRIPTION="Electric is a sophisticated electrical CAD system that can  handle many forms of circuit design"
HOMEPAGE="http://www.gnu.org/software/electric/electric.html"
SRC_URI="http://ftp.gnu.org/pub/gnu/electric/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

DEPEND="!qt3? ( x11-libs/openmotif )
	qt3? ( x11-libs/qt:3 )"

src_unpack() {
	unpack ${A}; cd "${S}"
	epatch "${FILESDIR}"/${PV}-fix-sandbox.patch
	epatch "${FILESDIR}"/${P}-gcc4.1-gentoo.patch
	use qt3 && epatch "${FILESDIR}"/${P}-qt-gentoo.patch
}

src_compile() {
	econf || die "./configure failed"
	sed -e 's:/usr/local/:/usr/:g' -i src/include/config.h
	emake OPTIMIZE="${CXXFLAGS}" || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc ChangeLog README
}
