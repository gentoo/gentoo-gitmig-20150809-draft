# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hs-plugins/hs-plugins-0.9.6.ebuild,v 1.5 2005/05/02 15:00:27 kosmikus Exp $

inherit base

IUSE="doc"

DESCRIPTION="Dynamically Loaded Haskell Plugins"
HOMEPAGE="http://www.cse.unsw.edu.au/~dons/hs-plugins/"
SRC_URI="ftp://ftp.cse.unsw.edu.au/pub/users/dons/${PN}/${P}.tar.gz
doc? ( http://www.cse.unsw.edu.au/~dons/${PN}/${PN}.html.tar.gz )"

SLOT="0"
KEYWORDS="~x86 ~ppc"
LICENSE="as-is"

DEPEND=">=virtual/ghc-6.2
	!>=virtual/ghc-6.4"

RDEPEND=""

src_compile() {
	econf
	emake -j1
}

src_install() {
	emake PREFIX=${D}/usr install

	dodoc AUTHORS README TODO VERSION

	if use doc; then
		dohtml ${WORKDIR}/${PN}/*
	fi
}

