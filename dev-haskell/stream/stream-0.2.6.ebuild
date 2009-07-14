# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/stream/stream-0.2.6.ebuild,v 1.1 2009/07/14 19:17:43 kolmodin Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

MY_PN="Stream"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A library for manipulating infinite lists."
HOMEPAGE="http://www.cs.nott.ac.uk/~wss/repos/Stream/dist/doc/html/"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1
		<dev-haskell/quickcheck-2"

DEPEND="${RDEPEND}
		dev-haskell/cabal"

S="${WORKDIR}/${MY_P}"
