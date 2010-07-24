# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/readline/readline-1.0.1.0.ebuild,v 1.1 2010/07/24 13:59:26 slyfox Exp $

CABAL_FEATURES="haddock lib profile"
inherit haskell-cabal

DESCRIPTION="Haskell interface to the GNU readline library"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/readline"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4"

CABAL_CORE_LIB_GHC_PV="6.8.1 6.8.2 6.8.3 6.10.1 6.10.2"
