# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/mmap/mmap-0.4.1.ebuild,v 1.9 2010/10/19 21:44:56 tomka Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Memory mapped files for POSIX and Windows"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/mmap"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc x86 ~ppc-macos"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2"
