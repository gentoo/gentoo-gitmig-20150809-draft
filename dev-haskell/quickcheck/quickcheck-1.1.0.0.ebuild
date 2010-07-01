# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/quickcheck/quickcheck-1.1.0.0.ebuild,v 1.9 2010/07/01 19:58:21 jer Exp $

CABAL_FEATURES="lib profile haddock"
CABAL_MIN_VERSION=1.2
inherit base haskell-cabal

MY_PN=QuickCheck
MY_P="${MY_PN}-${PV}"

DESCRIPTION="An automatic, specification based testing utility for Haskell programs"
HOMEPAGE="http://haskell.org/ghc/"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="1"
KEYWORDS="alpha amd64 ia64 ~ppc sparc x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6"

S="${WORKDIR}/${MY_P}"

PATCHES=("${FILESDIR}/${P}-ghc-6.10-build-fix.patch")
