# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/schoca/schoca-0.3.0.ebuild,v 1.1 2008/01/08 15:57:19 hkbst Exp $

DESCRIPTION="Schoca is a Scheme implementation in OCaml."

HOMEPAGE="http://home.arcor.de/chr_bauer/schoca.html
		  http://chesslib.sourceforge.net/"

SRC_URI="mirror://sourceforge/chesslib/${P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~amd64"

IUSE=""

DEPEND="dev-ml/findlib"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}; cd "${S}"
	cp OCaml.mk OCaml.mk.old
	sed "s:\$(CFLAGS):\$(CCFLAGS):g" -i OCaml.mk
	sed "s:CCFLAGS= -ccopt -O2:CCFLAGS= -ccopt \"${CFLAGS}\":" -i OCaml.mk
	diff -u OCaml.mk.old OCaml.mk
}

src_compile() {
	#parallel fails
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
