# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/schoca/schoca-0.3.0.ebuild,v 1.2 2008/01/17 19:35:08 aballier Exp $

EAPI="1"

inherit eutils

RESTRICT="installsources"

DESCRIPTION="Schoca is a Scheme implementation in OCaml."

HOMEPAGE="http://home.arcor.de/chr_bauer/schoca.html
		  http://chesslib.sourceforge.net/"

SRC_URI="mirror://sourceforge/chesslib/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND="dev-ml/findlib"
RDEPEND="${DEPEND}"

pkg_setup() {
	if use ocamlopt && ! built_with_use --missing true dev-lang/ocaml ocamlopt; then
		eerror "In order to build ${PN} with native code support from ocaml"
		eerror "You first need to have a native code ocaml compiler."
		eerror "You need to install dev-lang/ocaml with ocamlopt useflag on."
		die "Please install ocaml with ocamlopt useflag"
	fi
}

src_unpack() {
	unpack ${A}; cd "${S}"
	cp OCaml.mk OCaml.mk.old
	sed "s:\$(CFLAGS):\$(CCFLAGS):g" -i OCaml.mk
	sed "s:CCFLAGS= -ccopt -O2:CCFLAGS= -ccopt \"${CFLAGS}\":" -i OCaml.mk
	sed -i -e "s:DESTDURFLAG:DESTDIRFLAG:" OCaml.mk
	if ! use ocamlopt; then
		sed -i -e 's/ \$(PROGRAM)\.opt/ \$(PROGRAM)/' OCaml.mk || die "sed failed"
		sed -i -e 's/ \$(LIBRARY)\.cmxa//' OCaml.mk || die "sed failed"
		sed -i -e 's/ \$(LIBRARY)\.a//' OCaml.mk || die "sed failed"
		sed -i -e 's/) \$(NCOBJECTS)/)/' OCaml.mk || die "sed failed"
	fi
	diff -u OCaml.mk.old OCaml.mk
}

src_compile() {
	#parallel fails
	emake -j1 || die "emake failed"
}

src_install() {
	use ocamlopt || export STRIP_MASK="*bin/schoca"
	dodir "$(ocamlfind printconf destdir)"
	emake PREFIX="/usr" DESTDIR="${D}" DESTDIRFLAG="-destdir ${D}$(ocamlfind printconf destdir)" install || die "emake install failed"
}
