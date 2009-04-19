# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/zlib/zlib-0.5.0.0.ebuild,v 1.1 2009/04/19 08:59:41 kolmodin Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Compression and decompression in the gzip and zlib formats"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/zlib"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2.1
		>=sys-libs/zlib-1.2"
