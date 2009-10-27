# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/xmonad-contrib/xmonad-contrib-0.9.ebuild,v 1.2 2009/10/27 08:01:05 kolmodin Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Third party extensions for xmonad"
HOMEPAGE="http://xmonad.org/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/mtl
		>=dev-haskell/x11-1.4.6.1
		dev-haskell/utf8-string
		~x11-wm/xmonad-${PV}"

DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2.1"

src_compile() {
	CABAL_CONFIGURE_FLAGS="--flags=-testing"
	CABAL_CONFIGURE_FLAGS="${CABAL_CONFIGURE_FLAGS} --flags=-use_xft"
	cabal_src_compile
}
