# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/camlzip/camlzip-1.03-r1.ebuild,v 1.2 2008/01/02 19:56:51 aballier Exp $

inherit findlib eutils

EAPI="1"

IUSE="+ocamlopt"

DESCRIPTION="Compressed file access ML library (ZIP, GZIP and JAR)"
HOMEPAGE="http://cristal.inria.fr/~xleroy/software.html#camlzip"
SRC_URI="http://caml.inria.fr/distrib/bazar-ocaml/${P}.tar.gz"

SLOT="1"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=">=dev-lang/ocaml-3.04 \
		>=sys-libs/zlib-1.1.3"

pkg_setup() {
	if use ocamlopt && ! built_with_use --missing true dev-lang/ocaml ocamlopt; then
		eerror "In order to build ${PN} with native code support from ocaml"
		eerror "You first need to have a native code ocaml compiler."
		eerror "You need to install dev-lang/ocaml with ocamlopt useflag on."
		die "Please install ocaml with ocamlopt useflag"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-Makefile-findlib.patch"
	sed -e "s/VERSION/${PV}/" "${FILESDIR}/META" >> META
}

src_compile() {
	emake all || die "Failed at compilation step !!!"
	if use ocamlopt; then
		emake allopt || die "Failed at ML compilation step !!!"
	fi
}

src_install() {
	findlib_src_install

	dodoc README
}
