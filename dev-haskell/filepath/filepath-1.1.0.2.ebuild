# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/filepath/filepath-1.1.0.2.ebuild,v 1.2 2009/12/13 07:09:17 mr_bones_ Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Library for manipulating FilePaths in a cross platform way."
HOMEPAGE="http://www-users.cs.york.ac.uk/~ndm/filepath/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1"
DEPEND="${RDEPEND}
		dev-haskell/cabal"

CABAL_CORE_LIB_GHC_PV="6.10.2 6.10.3 6.10.4"
