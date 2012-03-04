# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hpc/hpc-0.5.1.1.ebuild,v 1.1 2012/03/04 03:30:06 gienah Exp $

EAPI="3"

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit haskell-cabal versionator

MY_PV=$(get_version_component_range '1-3')
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Code Coverage Library for Haskell"
HOMEPAGE="http://hackage.haskell.org/package/hpc"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

S="${WORKDIR}/${PN}-${MY_PV}"

CABAL_CORE_LIB_GHC_PV="7.4.0.20111219 7.4.0.20120126 7.4.1"
