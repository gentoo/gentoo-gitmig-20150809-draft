# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/camlimages/camlimages-2.20.ebuild,v 1.3 2005/06/22 12:02:53 george Exp $

inherit findlib

IUSE=""

DESCRIPTION="Library used by active-dvi"
HOMEPAGE="http://pauillac.inria.fr/advi/"
SRC_URI="ftp://ftp.inria.fr/INRIA/caml-light/bazar-ocaml/${P/20/2}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"

DEPEND=">=dev-lang/ocaml-3.06"

MY_S="${WORKDIR}/${P/20/2}"

src_compile() {
	cd ${MY_S}
	econf || die
	emake -j1 || die
	emake -j1 opt || die
}

src_test() {
	cd ${MY_S}/test
	make
	./test
	./test.byt
}

src_install() {
	# Use findlib to install properly, especially to avoid
	# the shared library mess
	findlib_src_preinst
	mkdir ${D}/tmp
	cd ${MY_S}
	make CAMLDIR=${D}/tmp \
		LIBDIR=${D}/tmp \
		DESTDIR=${D}/tmp \
		install || die
	sed -e "s/VERSION/${PV}/" ${FILESDIR}/META > ${D}/tmp/META

	ocamlfind install camlimages ${D}/tmp/*
	rm -rf ${D}/tmp
}
