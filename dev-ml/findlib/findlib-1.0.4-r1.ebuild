# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/findlib/findlib-1.0.4-r1.ebuild,v 1.9 2006/04/21 19:53:48 tcort Exp $

IUSE="tcltk"

DESCRIPTION="OCaml tool to find/use non-standard packages."
HOMEPAGE="http://www.ocaml-programming.de/packages/"
SRC_URI="http://www.ocaml-programming.de/packages/${P}.tar.gz"

LICENSE="MIT X11"

SLOT="0"
KEYWORDS="~alpha amd64 ia64 ppc ppc-macos ~ppc64 sparc x86"

DEPEND=">=dev-lang/ocaml-3.07"

ocamlfind_destdir="/usr/lib/ocaml/site-packages"
stublibs=${ocamlfind_destdir}/stublibs

pkg_setup()
{
	if ( use tcltk && which ocaml && ! which labltk ); then
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
		-sitelib ${ocamlfind_destdir} \
		-config ${ocamlfind_destdir}/findlib/findlib.conf || die "configure failed"

	make all || die
	make opt || die # optimized code
}

src_install() {
	dodir `ocamlc -where`

	make prefix=${D} install || die

	dodir ${stublibs}

	cd ${S}/doc
	dodoc QUICKSTART README
	dohtml html/*
}

check_stublibs() {
	local ocaml_stdlib=`ocamlc -where`
	local ldconf=${ocaml_stdlib}/ld.conf

	if [ ! -e ${ldconf} ]
	then
		echo ${ocaml_stdlib} > ${ldconf}
		echo ${ocaml_stdlib}/stublibs >> ${ldconf}
	fi

	if [ -z `grep -e ${stublibs} ${ldconf}` ]
	then
		echo ${stublibs} >> ${ldconf}
	fi
}

pkg_postinst() {
	check_stublibs
}