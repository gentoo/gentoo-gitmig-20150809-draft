# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/time/time-1.1.2.0.ebuild,v 1.6 2010/07/11 15:45:55 slyfox Exp $

CABAL_FEATURES="lib profile haddock"
CABAL_MIN_VERSION=1.2
inherit base haskell-cabal

DESCRIPTION="A Haskell time library."
HOMEPAGE="http://haskell.org/ghc/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc sparc x86"
IUSE=""

# upstream does not implement 'cabal test' yet
# addresses https://bugs.gentoo.org/show_bug.cgi?id=314587
RESTRICT="test"

DEPEND=">=dev-lang/ghc-6.6"

PATCHES=("${FILESDIR}/time-1.1.2.0-remove-werror.patch")
