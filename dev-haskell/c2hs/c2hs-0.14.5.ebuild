# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/c2hs/c2hs-0.14.5.ebuild,v 1.14 2010/04/11 18:27:53 armin76 Exp $

CABAL_FEATURES="bin"
inherit base eutils haskell-cabal

DESCRIPTION="An interface generator for Haskell"
HOMEPAGE="http://www.cse.unsw.edu.au/~chak/haskell/c2hs/"
SRC_URI="http://www.cse.unsw.edu.au/~chak/haskell/c2hs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4"

src_unpack() {
	base_src_unpack
	cd "${S}"
	epatch "${FILESDIR}/setupfix.patch"
	epatch "${FILESDIR}/ghc622inc.patch"
	epatch "${FILESDIR}/${P}-ghc66.patch"
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
