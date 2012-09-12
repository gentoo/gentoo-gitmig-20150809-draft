# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/haskell-src/haskell-src-1.0.1.3.ebuild,v 1.7 2012/09/12 15:32:33 qnikst Exp $

CABAL_FEATURES="lib profile haddock happy"
inherit haskell-cabal

DESCRIPTION="Manipulating Haskell source code"
HOMEPAGE="http://haskell.org/ghc/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1"

DEPEND="$RDEPEND
		>=dev-haskell/cabal-1.2"
