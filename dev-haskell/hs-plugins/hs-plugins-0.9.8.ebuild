# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hs-plugins/hs-plugins-0.9.8.ebuild,v 1.1 2005/02/23 09:45:59 kosmikus Exp $

inherit base ghc-package

IUSE="doc"

DESCRIPTION="Dynamically Loaded Haskell Plugins"
HOMEPAGE="http://www.cse.unsw.edu.au/~dons/hs-plugins/"
SRC_URI="ftp://ftp.cse.unsw.edu.au/pub/users/dons/${PN}/${P}.tar.gz
doc? ( http://www.cse.unsw.edu.au/~dons/${PN}/${PN}.html.tar.gz )"

SLOT="0"
KEYWORDS="~x86 ~ppc"
LICENSE="as-is"

DEPEND=">=virtual/ghc-6.2"

RDEPEND=""

src_unpack() {
	unpack ${A}
	# for package management
	sed -i 's:ghc-pkg -u:\${GHC_PKGF} -u:' ${S}/Makefile
}

src_compile() {
	econf
	# for package management
	echo 'GHC_PKGF = ${GHC_PKG} -f '"${S}/$(ghc-localpkgconf)" >> config.mk
	emake -j1
}

src_install() {
	emake PREFIX="${D}/usr" install
	ghc-setup-pkg
	emake PREFIX="${D}/usr" register # then we don't need --force in ghc-pkg
	ghc-install-pkg

	dodoc AUTHORS README TODO VERSION

	if use doc; then
		dohtml ${WORKDIR}/${PN}/*
	fi
}

