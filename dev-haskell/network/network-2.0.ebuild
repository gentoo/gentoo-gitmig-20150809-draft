# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/network/network-2.0.ebuild,v 1.2 2007/04/04 20:15:40 cparrott Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

GHC_PV=6.6

DESCRIPTION="Haskell network library"
HOMEPAGE="http://haskell.org/ghc/"
SRC_URI="http://www.haskell.org/ghc/dist/${GHC_PV}/ghc-${GHC_PV}-src-extralibs.tar.bz2"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~alpha ~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/ghc-6.6"

S="${WORKDIR}/ghc-${GHC_PV}/libraries/${PN}"
