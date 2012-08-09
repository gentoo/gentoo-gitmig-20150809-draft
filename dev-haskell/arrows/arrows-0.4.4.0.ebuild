# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/arrows/arrows-0.4.4.0.ebuild,v 1.6 2012/08/09 10:05:26 slyfox Exp $

EAPI=4

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Arrow classes and transformers"
HOMEPAGE="http://www.haskell.org/arrows/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND="dev-haskell/stream[profile?]
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		dev-haskell/cabal"
