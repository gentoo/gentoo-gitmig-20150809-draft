# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/iconv/iconv-0.4.ebuild,v 1.1 2007/12/15 18:38:13 dcoutts Exp $

CABAL_FEATURES="profile haddock lib"
CABAL_MIN_VERSION=1.2
inherit haskell-cabal

DESCRIPTION="String encoding conversion"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/iconv"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4.2"
