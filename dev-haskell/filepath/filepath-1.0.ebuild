# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/filepath/filepath-1.0.ebuild,v 1.14 2010/07/01 19:23:31 jer Exp $

CABAL_FEATURES="haddock lib profile"
inherit haskell-cabal

DESCRIPTION="Utilities for filepath handling."
HOMEPAGE="http://www-users.cs.york.ac.uk/~ndm/projects/libraries.php"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"

KEYWORDS="amd64 ~ia64 ppc sparc x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4"

CABAL_CORE_LIB_GHC_PV="6.6.1"
