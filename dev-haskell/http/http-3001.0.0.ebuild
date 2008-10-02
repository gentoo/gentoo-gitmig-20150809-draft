# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/http/http-3001.0.0.ebuild,v 1.3 2008/10/02 20:21:35 jer Exp $

CABAL_FEATURES="profile haddock lib"
CABAL_MIN_VERSION=1.2
inherit haskell-cabal

MY_PN="HTTP"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A library for client-side HTTP"
HOMEPAGE="http://www.haskell.org/http/"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4.2
		dev-haskell/network"

S="${WORKDIR}/${MY_P}"
