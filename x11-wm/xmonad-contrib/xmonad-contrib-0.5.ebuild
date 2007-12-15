# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/xmonad-contrib/xmonad-contrib-0.5.ebuild,v 1.1 2007/12/15 23:23:57 kolmodin Exp $

CABAL_FEATURES="lib profile haddock"
CABAL_MIN_VERSION=1.2

inherit haskell-cabal

DESCRIPTION="Third party extentions for xmonad"
HOMEPAGE="http://www.xmonad.org/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"

DEPEND="dev-haskell/mtl
	~x11-wm/xmonad-${PV}
	>=dev-lang/ghc-6.6"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}

	# -Werror is really fragile, what if ghc adds new warnings?
	sed -i -e 's/-Werror//' "${S}/xmonad-contrib.cabal"
}

src_compile() {
	CABAL_CONFIGURE_FLAGS="--flags=-use_xft"
	cabal_src_compile
}
