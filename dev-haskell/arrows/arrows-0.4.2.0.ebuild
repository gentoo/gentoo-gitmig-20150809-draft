# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/arrows/arrows-0.4.2.0.ebuild,v 1.1 2010/07/13 15:46:22 slyfox Exp $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Arrow classes and transformers"
HOMEPAGE="http://www.haskell.org/arrows/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.10
		dev-haskell/cabal
		dev-haskell/stream"
