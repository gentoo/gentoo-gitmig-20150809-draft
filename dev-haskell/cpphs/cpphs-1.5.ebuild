# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/cpphs/cpphs-1.5.ebuild,v 1.2 2007/11/24 11:33:39 kolmodin Exp $

CABAL_FEATURES="profile haddock lib bin"
inherit haskell-cabal

DESCRIPTION="A liberalised re-implementation of cpp, the C pre-processor."
HOMEPAGE="http://haskell.org/cpphs/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4.2"

src_install() {
	cabal_src_install
	dohtml docs/index.html
	doman docs/cpphs.1
}
