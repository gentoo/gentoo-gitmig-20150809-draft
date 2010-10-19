# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/digest/digest-0.0.0.8.ebuild,v 1.7 2010/10/19 21:52:24 tomka Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Various cryptographic hashes for bytestrings; CRC32 and Adler32 for now."
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/digest"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.6
		sys-libs/zlib"
