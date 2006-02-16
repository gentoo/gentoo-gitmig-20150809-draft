# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/c2hs/c2hs-0.14.5.ebuild,v 1.3 2006/02/16 13:14:26 dcoutts Exp $

CABAL_FEATURES="bin"
inherit base eutils haskell-cabal

DESCRIPTION="An interface generator for Haskell"
HOMEPAGE="http://www.cse.unsw.edu.au/~chak/haskell/c2hs/"
SRC_URI="http://www.cse.unsw.edu.au/~chak/haskell/c2hs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE=""

DEPEND=">=virtual/ghc-6.0"

src_unpack() {
	base_src_unpack
	cd "${S}"
	epatch "${FILESDIR}/setupfix.patch"
}
src_install() {
	cabal_src_install
	exeinto /usr
	dobin c2hs/c2hs
	insinto "/usr/lib/${P}"
	doins "${S}/c2hs/lib/C2HS.hs"
	exeinto "/usr/lib/${P}"
	doexe dist/build/c2hs/c2hs
}
