# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/pxp/pxp-1.1.5.ebuild,v 1.5 2003/09/08 03:01:53 msterret Exp $

DESCRIPTION="validating XML parser library for O'Caml"
HOMEPAGE="http://www.ocaml-programming.de/packages/documentation/pxp/index_dev.html"
SRC_URI="http://www.ocaml-programming.de/packages/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=dev-ml/pcre-ocaml-4.31
	>=dev-ml/ocamlnet-0.94
	>=dev-ml/findlib-0.8"

src_compile() {
	#the included configure does not support  many standard switches and is quite picky
	./configure || die
	make all opt || die
}

src_install() {
	local destdir=`ocamlfind printconf destdir`
	dodir ${destdir}
	make OCAMLFIND_DESTDIR=${D}${destdir} install || die
}
