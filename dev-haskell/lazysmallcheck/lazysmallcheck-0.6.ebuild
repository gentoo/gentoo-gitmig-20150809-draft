# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/lazysmallcheck/lazysmallcheck-0.6.ebuild,v 1.3 2012/08/09 10:02:45 slyfox Exp $

EAPI=4

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="A library for demand-driven testing of Haskell programs"
HOMEPAGE="http://www.cs.york.ac.uk/~mfn/lazysmallcheck/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha ~amd64 ia64 ppc ~ppc64 sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.8.2"
DEPEND="${RDEPEND}
		dev-haskell/cabal"
