# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/xhtml/xhtml-3000.0.2.1.ebuild,v 1.5 2010/07/01 19:59:41 jer Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="XHTML combinator library for haskell"
HOMEPAGE="http://haskell.org/ghc/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc sparc x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4"
