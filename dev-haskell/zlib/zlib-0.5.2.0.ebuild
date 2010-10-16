# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/zlib/zlib-0.5.2.0.ebuild,v 1.6 2010/10/16 18:21:45 hwoarang Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Compression and decompression in the gzip and zlib formats"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/zlib"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~ppc-macos"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1
		>=sys-libs/zlib-1.2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2.1"
