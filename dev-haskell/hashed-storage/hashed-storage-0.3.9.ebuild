# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hashed-storage/hashed-storage-0.3.9.ebuild,v 1.1 2009/12/13 12:01:24 kolmodin Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Hashed file storage support code."
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/hashed-storage"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# not depending on extensible-exceptions forces us to depend on >=ghc-6.10
RDEPEND=">=dev-lang/ghc-6.10
		dev-haskell/filepath
		=dev-haskell/mmap-0.4*
		dev-haskell/mtl
		dev-haskell/zlib"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"
