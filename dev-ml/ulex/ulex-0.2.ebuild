# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ulex/ulex-0.2.ebuild,v 1.2 2004/03/22 23:22:50 mattam Exp $

IUSE=""

DESCRIPTION="ulex: a lexer generator for unicode"
HOMEPAGE="http://www.cduce.org"
SRC_URI="http://www.cduce.org/download/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND=">=dev-lang/ocaml-3.06
	>=dev-ml/findlib-0.8"

src_compile() {
	epatch ${FILESDIR}/${P}-Makefile.patch
	make all || die
	make all.opt || die
}

src_install() {
	local destdir=`ocamlfind printconf destdir`
	dodir ${destdir}
	cp /usr/lib/ocaml/ld.conf ${D}/usr/lib/ocaml/ld.conf
	make OCAMLFIND_LDCONF=${D}/usr/lib/ocaml/ld.conf.wlex OCAMLFIND_DESTDIR=${D}${destdir} install || die
	echo "/usr/lib/ocaml/site-packages/ulex" >> ${D}/usr/lib/ocaml/ld.conf
	dodoc README CHANGES LICENSE
}
