# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/cpphs/cpphs-1.7.ebuild,v 1.2 2010/07/24 18:10:59 slyfox Exp $

CABAL_FEATURES="bin lib profile haddock"
inherit haskell-cabal

DESCRIPTION="A liberalised re-implementation of cpp, the C pre-processor."
HOMEPAGE="http://haskell.org/cpphs/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
	dev-haskell/cabal"
RDEPEND=""

src_install() {
	cabal_src_install
	dohtml docs/index.html
	doman docs/cpphs.1
}
