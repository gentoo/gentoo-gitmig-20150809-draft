# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamlnet/ocamlnet-0.95.ebuild,v 1.5 2004/03/23 01:10:35 mattam Exp $

DESCRIPTION="Modules for O'Caml application-level Internet protocols"
HOMEPAGE="http://ocamlnet.sourceforge.net"
SRC_URI="mirror://sourceforge/ocamlnet/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND=">=dev-ml/pcre-ocaml-4.31.0
	>=dev-ml/findlib-0.8"

IUSE=""
S="${WORKDIR}/${P}/src"

src_compile() {
	./configure || die
	make all opt || die
}

src_install() {
	# must create destdir beforehand
	destdir=`ocamlfind printconf destdir`
	mkdir -p ${D}${destdir} || die
	# install
	make OCAMLFIND_DESTDIR=${D}${destdir} install || die

	cd ${WORKDIR}/${P}
	dodoc README
	dohtml doc/intro/html/*
}
