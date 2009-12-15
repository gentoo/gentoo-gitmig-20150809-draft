# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hscolour/hscolour-1.15.ebuild,v 1.1 2009/12/15 22:55:23 kolmodin Exp $

CABAL_FEATURES="bin lib profile haddock"
inherit base haskell-cabal

DESCRIPTION="Colourise Haskell code."
HOMEPAGE="http://www.cs.york.ac.uk/fp/darcs/hscolour/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

PATCHES=("${FILESDIR}/hscolour-0.15-utf8-aware.diff")

src_install() {
	cabal_src_install
	if use doc; then
		dohtml index.html hscolour.css
		dodoc README
	fi
}
