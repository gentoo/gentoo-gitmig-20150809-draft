# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/happy/happy-1.14.ebuild,v 1.3 2004/06/24 22:15:05 agriffis Exp $

DESCRIPTION="A yacc-like parser generator for Haskell"
HOMEPAGE="http://haskell.org/happy/"
SRC_URI="http://haskell.cs.yale.edu/happy/dist/${PV}/${P}-src.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/ghc"
RDEPEND=""

src_unpack() {
	unpack ${A}
}

src_compile() {
	econf || die

	# "emake" does not work reliably. Probably due to the classic
	# dependency problem in make with parallel builds.
	make || die
}

src_install() {
	einstall || die
}
