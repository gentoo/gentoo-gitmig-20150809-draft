# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/llpp/llpp-7.ebuild,v 1.5 2012/04/29 03:56:55 xmw Exp $

EAPI=3

inherit eutils toolchain-funcs

DESCRIPTION="a graphical PDF viewer which aims to superficially resemble less(1)"
HOMEPAGE="http://repo.or.cz/w/llpp.git"
SRC_URI="mirror://gentoo/${P}.tar.gz"
#SRC_URI="http://repo.or.cz/w/llpp.git/snapshot/dabcf41a34eb6ebb1a539f8369c8fec15f94db1c.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="vanilla"

RDEPEND="=app-text/mupdf-0.9
	dev-ml/lablgl[glut]
	dev-lang/ocaml[ocamlopt]
	media-libs/jbig2dec
	media-libs/openjpeg
	x11-misc/xsel"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_prepare() {
	use vanilla || epatch "${FILESDIR}"/${PN}-WM_CLASS.patch
}

src_compile() {
	ocaml str.cma keystoml.ml KEYS > help.ml || die
	printf 'let version ="%s";;\n' ${PV} >> help.ml || die

	local myccopt="$(freetype-config --cflags) -O -include ft2build.h -D_GNU_SOURCE"
	local mycclib="-lmupdf -lfitz -lz -ljpeg -lopenjpeg -ljbig2dec -lfreetype -lpthread"
	#if use ocamlopt ; then
		myccopt="${myccopt} -lpthread"
		ocamlopt -c -o link.o -ccopt "${myccopt}" link.c || die
		ocamlopt -c -o help.cmx help.ml || die
		ocamlopt -c -o parser.cmx parser.ml || die
		ocamlopt -c -o main.cmx -I +lablGL main.ml || die
	    ocamlopt -o llpp -I +lablGL \
			str.cmxa unix.cmxa lablgl.cmxa lablglut.cmxa link.o \
		    -cclib "${mycclib}" help.cmx parser.cmx main.cmx || die
	#else
	#	ocamlc -c -o link.o -ccopt "${myccopt}" link.c || die
	#	ocamlc -c -o help.cmo help.ml || die
	#	ocamlc -c -o parser.cmo parser.ml || die
	#	ocamlc -c -o main.cmo -I +lablGL main.ml || die
	#	ocamlc -custom -o llpp -I +lablGL \
	#		str.cma unix.cma lablgl.cma lablglut.cma link.o \
	#		-cclib "${mycclib}" help.cmo parser.cmo main.cmo || die
	#fi
}

src_install() {
	dobin ${PN} || die
	dodoc KEYS README Thanks fixme || die
}
