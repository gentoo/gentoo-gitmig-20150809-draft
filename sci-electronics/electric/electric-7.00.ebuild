# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/electric/electric-7.00.ebuild,v 1.10 2006/08/21 04:29:01 tcort Exp $

inherit eutils qt3

IUSE="qt3"

DESCRIPTION="Electric is a sophisticated electrical CAD system that can  handle many forms of circuit design"
HOMEPAGE="http://www.gnu.org/software/electric/electric.html"
SRC_URI="http://ftp.gnu.org/pub/gnu/electric/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

DEPEND="virtual/libc
	!qt3? ( virtual/motif )
	qt3? ( $(qt_min_version 3.1) )"

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

	dodoc ChangeLog COPYING README
}
