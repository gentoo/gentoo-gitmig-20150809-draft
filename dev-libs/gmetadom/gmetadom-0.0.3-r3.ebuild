# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gmetadom/gmetadom-0.0.3-r3.ebuild,v 1.1 2003/04/18 06:37:42 george Exp $

IUSE=""

DESCRIPTION="A library providing bindings for multiple languages of multiple C DOM implementations"
HOMEPAGE="http://gmetadom.sf.net"
SRC_URI="http://belnet.dl.sourceforge.net/sourceforge/gmetadom/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"

DEPEND="
	>=findlib-0.8
	>=libxslt-1.0.0
	>=gdome2-0.7.2"

RDEPEND=">=gdome2-0.7.2"

S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}
	cd ${S}/src/gdome_caml
	cp Makefile.am Makefile.am.orig
	sed -e 's:$(OCAMLFIND) install gdome2 META .libs/libmlgdome.so ;:$(OCAMLFIND) install -destdir=${DESTDIR}/usr/lib/ocaml/site-packages gdome2 META .libs/libmlgdome.so ;:' \
		Makefile.am.orig > Makefile.am.2
	sed -e 's:ocamllibdir = $(OCAML_LIB_PREFIX)/gdome2:ocamllibdir = $(OCAML_LIB_PREFIX)/site-packages/gdome2:' \
			Makefile.am.2 > Makefile.am.3
	sed -e 's:OCAMLINSTALLDIR = $(DESTDIR)$(OCAML_LIB_PREFIX)/gdome2:OCAMLINSTALLDIR = ${DESTDIR}$(OCAML_LIB_PREFIX)/site-packages/gdome2:' \
			Makefile.am.3 > Makefile.am
	cd ${S}
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

	dodoc AUTHORS BUGS ChangeLog COPYING HISTORY LICENSE NEWS README
	dohtml -r doc/html/*
}
