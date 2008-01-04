# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamlgraph/ocamlgraph-0.99b.ebuild,v 1.1 2008/01/04 01:27:16 aballier Exp $

inherit findlib eutils

EAPI="1"

DESCRIPTION="O'Caml Graph library"
HOMEPAGE="http://www.lri.fr/~filliatr/ocamlgraph/"
SRC_URI="http://www.lri.fr/~filliatr/ftp/ocamlgraph/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
DEPEND=">=dev-lang/ocaml-3.08
	doc? ( dev-tex/hevea dev-ml/ocamlweb )
	gtk? ( dev-ml/lablgtk )"
IUSE="doc examples gtk +ocamlopt"

ocamlgraph_need_use() {
	if ! built_with_use --missing true $1 $2; then
		eerror "In order to build ${PN} with your useflags you first need to build $1 with $2 useflag"
		die "Please install $1 with $2 useflag"
	fi
}

pkg_setup() {
	use ocamlopt && ocamlgraph_need_use 'dev-lang/ocaml' ocamlopt
	use gtk && ocamlgraph_need_use 'dev-ml/lablgtk' gnomecanvas
	use ocamlopt && use gtk && ocamlgraph_need_use 'dev-lang/lablgtk' ocamlopt
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-installfindlib.patch"
}

src_compile() {
	econf
	emake -j1 || die "failed to build"

	if use doc;	then
		emake doc || die "making documentation failed"
	fi
	if use gtk; then
		emake -j1 editor || die "compiling editor failed"
	fi
}

src_install() {
	findlib_src_preinst
	emake install-findlib || die "make install failed"

	if use gtk; then
		if use ocamlopt; then
			newbin editor/editor.opt ocamlgraph_editor || die "failed to install ocamlgraph_editor"
		else
			newbin editor/editor.byte ocamlgraph_editor || die "failed to install ocamlgraph_editor"
		fi
	fi
	dodoc README CREDITS FAQ CHANGES
	if use doc; then
		dohtml doc/*
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
