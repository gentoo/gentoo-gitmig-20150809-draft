# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/xmonad-contrib/xmonad-contrib-0.9.ebuild,v 1.3 2011/03/22 19:22:48 angelos Exp $

CABAL_FEATURES="lib profile haddock"
EAPI=3
inherit haskell-cabal

DESCRIPTION="Third party extensions for xmonad"
HOMEPAGE="http://xmonad.org/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/mtl[profile?]
		>=dev-haskell/x11-1.4.6.1[profile?]
		dev-haskell/utf8-string
		~x11-wm/xmonad-${PV}[profile?]"

DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2.1"

src_compile() {
	CABAL_CONFIGURE_FLAGS="--flags=-testing"
	CABAL_CONFIGURE_FLAGS="${CABAL_CONFIGURE_FLAGS} --flags=-use_xft"
	cabal_src_compile
}
