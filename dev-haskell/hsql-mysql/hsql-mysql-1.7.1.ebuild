# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hsql-mysql/hsql-mysql-1.7.1.ebuild,v 1.2 2010/07/12 15:47:40 slyfox Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="MySQL driver for HSQL."
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/hsql-mysql"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/hsql-$(get_version_component_range 1-2 ${PV})
		>=virtual/mysql-4.0"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"
