# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/bzlib/bzlib-0.5.0.0.ebuild,v 1.1 2009/12/15 22:08:39 kolmodin Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Compression and decompression in the bzip2 format"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/bzlib"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1
		>=app-arch/bzip2-1.0"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2.1"
