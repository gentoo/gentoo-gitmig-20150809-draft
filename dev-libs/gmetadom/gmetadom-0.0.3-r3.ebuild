# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gmetadom/gmetadom-0.0.3-r3.ebuild,v 1.5 2004/04/16 02:37:59 vapier Exp $

inherit eutils

DESCRIPTION="A library providing bindings for multiple languages of multiple C DOM implementations"
HOMEPAGE="http://gmetadom.sourceforge.net/"
SRC_URI="mirror://sourceforge/gmetadom/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=dev-ml/findlib-0.8
	>=dev-libs/libxslt-1.0.0
	>=dev-libs/gdome2-0.7.2"
RDEPEND=">=dev-libs/gdome2-0.7.2"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e 's:$(OCAMLFIND) install gdome2 META .libs/libmlgdome.so ;:$(OCAMLFIND) install -destdir=${DESTDIR}/usr/lib/ocaml/site-packages gdome2 META .libs/libmlgdome.so ;:' \
		-e 's:ocamllibdir = $(OCAML_LIB_PREFIX)/gdome2:ocamllibdir = $(OCAML_LIB_PREFIX)/site-packages/gdome2:' \
		-e 's:OCAMLINSTALLDIR = $(DESTDIR)$(OCAML_LIB_PREFIX)/gdome2:OCAMLINSTALLDIR = ${DESTDIR}$(OCAML_LIB_PREFIX)/site-packages/gdome2:' \
		src/gdome_caml/Makefile.am
	automake

	epatch ${FILESDIR}/${P}-gcc3.diff
}

src_compile() {
	econf || die
	make || die
}

src_install() {
	make DESTDIR=${D} OCAMLINSTALLDIR=${D}/usr/lib/ocaml/site-packages/gdome2 install || die

	echo LDPATH=/usr/lib/ocaml/site-packages/gdome2 > 97gdome2
	insinto /etc/env.d
	doins 97gdome2

	dodoc AUTHORS BUGS ChangeLog HISTORY NEWS README
	dohtml -r doc/html/*
}
