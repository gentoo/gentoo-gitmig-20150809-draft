# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/happy/happy-1.14.ebuild,v 1.7 2005/03/19 13:12:49 kosmikus Exp $

inherit base eutils

DESCRIPTION="A yacc-like parser generator for Haskell"
HOMEPAGE="http://haskell.org/happy/"
SRC_URI="http://haskell.cs.yale.edu/happy/dist/${PV}/${P}-src.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/ghc
	!>=virtual/ghc-6.4"
RDEPEND=""

src_unpack() {
	base_src_unpack
	epatch "${FILESDIR}/${P}-gcc3.4.patch"
}

src_compile() {
	econf || die "configure failed"
	emake -j1 || die "make failed"
}

src_install() {
	einstall || die "installation failed"
}
