# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/stream/stream-0.2.6-r1.ebuild,v 1.7 2011/06/30 12:18:14 tomka Exp $

EAPI=1

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

MY_PN="Stream"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A library for manipulating infinite lists."
HOMEPAGE="http://www.cs.nott.ac.uk/~wss/repos/Stream/dist/doc/html/"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/quickcheck:1"

DEPEND="${RDEPEND}
		dev-haskell/cabal"

S="${WORKDIR}/${MY_P}"
