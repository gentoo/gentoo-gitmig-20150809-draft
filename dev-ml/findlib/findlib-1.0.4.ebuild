# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/findlib/findlib-1.0.4.ebuild,v 1.2 2004/08/09 18:46:24 mr_bones_ Exp $

DESCRIPTION="OCaml tool to find/use non-standard packages."
HOMEPAGE="http://www.ocaml-programming.de/packages/"
SRC_URI="http://www.ocaml-programming.de/packages/${P}.tar.gz"

LICENSE="MIT X11"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="tcltk"

DEPEND=">=dev-lang/ocaml-3.07"

pkg_setup() {
	if use tcltk && which ocaml && ! which labltk ; then
		eerror "It seems you don't have ocaml compiled with tk support"
		eerror ""
		eerror "The findlib toolbox requires ocaml be built with tk support."
		eerror ""
		eerror "Please make sure that ocaml is installed with tk support or remove the USE flag"

		false;
	fi
}

src_compile() {
	./configure

	./configure -bindir /usr/bin -mandir /usr/share/man \
		-sitelib /usr/lib/ocaml/site-packages/ \
		-config /usr/lib/ocaml/site-packages/findlib/findlib.conf || die "configure failed"

	make all || die
	make opt || die # optimized code
}

src_install() {
	make prefix=${D} install || die

	cd ${S}/doc
	dodoc QUICKSTART README
	dohtml html/*
}
