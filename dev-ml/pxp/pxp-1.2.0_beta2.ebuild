# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/pxp/pxp-1.2.0_beta2.ebuild,v 1.1 2008/04/09 07:59:20 aballier Exp $

EAPI="1"

inherit findlib eutils

MY_P=${P/_beta/test}

DESCRIPTION="validating XML parser library for O'Caml"
HOMEPAGE="http://www.ocaml-programming.de/packages/documentation/pxp/index_dev.html"
SRC_URI="http://www.ocaml-programming.de/packages/${MY_P}.tar.gz"

LICENSE="as-is"
KEYWORDS="~amd64 ~ppc ~x86"

SLOT="0"
DEPEND=">=dev-ml/pcre-ocaml-4.31
>=dev-ml/ulex-0.5
>=dev-ml/ocamlnet-0.98
>=dev-lang/ocaml-3.09"

IUSE="examples +ocamlopt"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	if use ocamlopt && ! built_with_use --missing true dev-lang/ocaml ocamlopt; then
		eerror "In order to build ${PN} with native code support from ocaml"
		eerror "You first need to have a native code ocaml compiler."
		eerror "You need to install dev-lang/ocaml with ocamlopt useflag on."
		die "Please install ocaml with ocamlopt useflag"
	fi
}

src_compile() {
	#the included configure does not support  many standard switches and is quite picky
	./configure || die "configure failed"
	emake -j1 all || die "make all failed"
	if use ocamlopt; then
		emake -j1 opt || die "make opt failed"
	fi
}

src_install() {
	findlib_src_install
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi

	cd doc
	dodoc ABOUT-FINDLIB DEV EXTENSIONS README SPEC design.txt
}
