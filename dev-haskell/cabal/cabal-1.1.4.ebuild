# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/cabal/cabal-1.1.4.ebuild,v 1.13 2010/07/01 19:20:29 jer Exp $

CABAL_FEATURES="bootstrap profile lib"
inherit haskell-cabal eutils base

DESCRIPTION="Haskell Common Architecture for Building Applications and Libraries"
HOMEPAGE="http://haskell.org/cabal"
SRC_URI="http://haskell.org/cabal/release/${P}/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"

KEYWORDS="~alpha amd64 ~ia64 ppc ppc64 sparc x86 ~x86-fbsd"

IUSE="doc"

DEPEND="<dev-lang/ghc-6.6"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-make.patch"
}

src_compile() {
	if ghc-cabal; then
		make setup HC="$(ghc-getghc) -ignore-package Cabal"
	else
		make setup HC="$(ghc-getghc)"
	fi
	cabal-configure
	cabal-build
}

src_install() {
	cabal_src_install

	# documentation (install directly; generation seems broken to me atm)
	dohtml -r doc/users-guide
	if use doc; then
		dohtml -r doc/API
		dohtml -r doc/pkg-spec-html
		dodoc doc/pkg-spec.pdf
	fi
	dodoc changelog copyright README releaseNotes TODO
}

pkg_postinst () {
	if ghc-cabal && ghc-package-exists "Cabal-1.0"; then
		ebegin "Unregistering ghc's built-in cabal "
		$(ghc-getghcpkg) unregister "Cabal-1.0" > /dev/null
		eend $?
	fi
	ghc-package_pkg_postinst
}
