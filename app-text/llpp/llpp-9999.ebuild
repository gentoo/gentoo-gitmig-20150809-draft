# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/llpp/llpp-9999.ebuild,v 1.7 2011/08/09 19:19:37 xmw Exp $

EAPI=3

EGIT_REPO_URI="git://repo.or.cz/llpp.git"

inherit git-2 toolchain-funcs

DESCRIPTION="a graphical PDF viewer which aims to superficially resemble less(1)"
HOMEPAGE="http://repo.or.cz/w/llpp.git"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=app-text/mupdf-0.8.165
	dev-ml/lablgl[glut]
	media-libs/jbig2dec
	media-libs/openjpeg
	x11-misc/xsel"
DEPEND="${RDEPEND}"

src_compile() {
	ocaml keystoml.ml KEYS > help.ml || die
	echo "let version =\"$(git describe --tags)\";;" >> help.ml
	ocamlopt -c -o link.o -ccopt -O link.c || die
	ocamlopt -c -o help.cmx help.ml || die
	ocamlopt -c -o parser.cmx parser.ml || die
	ocamlopt -c -o main.cmx -I +lablGL main.ml || die

	ocamlopt -o llpp \
		-I +lablGL str.cmxa unix.cmxa lablgl.cmxa lablglut.cmxa link.o \
		-cclib "-lmupdf -lfitz -lz -ljpeg -lopenjpeg -ljbig2dec -lfreetype -lpthread" \
		help.cmx parser.cmx main.cmx || die
}

src_install() {
	dobin ${PN} || die
	dodoc KEYS Thanks fixme || die
}
