# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/zlib/zlib-0.5.2.0.ebuild,v 1.2 2010/04/01 10:40:37 grobian Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Compression and decompression in the gzip and zlib formats"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/zlib"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~sparc ~x86 ~ppc-macos"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1
		>=sys-libs/zlib-1.2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2.1"
