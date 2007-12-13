# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/alut/alut-2.1.0.0.ebuild,v 1.1 2007/12/13 17:46:52 dcoutts Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

MY_PN="ALUT"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A Haskell binding for the OpenAL Utility Toolkit"
HOMEPAGE="http://haskell.org/ghc/"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4
	>=dev-haskell/opengl-2.2.1
	>=dev-haskell/openal-1.3.1
	media-libs/freealut"

S="${WORKDIR}/${MY_P}"

#TODO: install examples perhaps?
