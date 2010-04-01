# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/terminfo/terminfo-0.3.1.1.ebuild,v 1.2 2010/04/01 10:34:44 grobian Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Haskell bindings to the terminfo library."
HOMEPAGE="http://code.haskell.org/terminfo"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86 ~ppc-macos"
IUSE=""

DEPEND=">=dev-lang/ghc-6.10
		>=dev-haskell/cabal-1.4
		sys-libs/ncurses"
