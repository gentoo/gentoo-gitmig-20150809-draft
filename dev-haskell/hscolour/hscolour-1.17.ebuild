# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hscolour/hscolour-1.17.ebuild,v 1.2 2010/08/08 18:52:15 phajdan.jr Exp $

CABAL_FEATURES="bin lib profile haddock"
inherit base haskell-cabal

DESCRIPTION="Colourise Haskell code."
HOMEPAGE="http://www.cs.york.ac.uk/fp/darcs/hscolour/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc64 ~sparc x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.6"
