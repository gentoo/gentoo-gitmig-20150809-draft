# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/cabal-install/cabal-install-0.8.0.ebuild,v 1.2 2010/10/02 21:37:04 slyfox Exp $

CABAL_FEATURES="bin"
inherit haskell-cabal bash-completion

DESCRIPTION="The command-line interface for Cabal and Hackage."
HOMEPAGE="http://www.haskell.org/cabal/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.4
		 >=dev-haskell/cabal-1.8"
DEPEND="${RDEPEND}
		>=dev-haskell/http-4000.0.2
		dev-haskell/network
		>=dev-haskell/zlib-0.4
		>=dev-haskell/time-1.1"

src_install() {
	haskell-cabal_src_install

	dobashcompletion "${S}/bash-completion/cabal"
}

pkg_postinst() {
	ghc-package_pkg_postinst

	bash-completion_pkg_postinst
}
