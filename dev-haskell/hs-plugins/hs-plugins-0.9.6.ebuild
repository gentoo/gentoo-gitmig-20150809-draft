# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hs-plugins/hs-plugins-0.9.6.ebuild,v 1.1 2004/10/20 23:00:52 mattam Exp $

inherit base

IUSE=""

DESCRIPTION="Dynamically Loaded Haskell Plugins"
HOMEPAGE="http://www.cse.unsw.edu.au/~dons/hs-plugins/"
SRC_URI="ftp://ftp.cse.unsw.edu.au/pub/users/dons/${PN}/${P}.tar.gz
doc? ( http://www.cse.unsw.edu.au/~dons/${PN}/${PN}.html.tar.gz )"

SLOT="0"
KEYWORDS="~x86 ~ppc"
LICENSE="as-is"

DEPEND=">=virtual/ghc-5.04"

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

