# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-sgml-dtd/docbook-sgml-dtd-4.2.ebuild,v 1.9 2004/04/26 11:24:38 obz Exp $

inherit sgml-catalog

MY_P="docbook-4.2"
DESCRIPTION="Docbook SGML DTD 4.2"
SRC_URI="http://www.oasis-open.org/docbook/sgml/${PV}/${MY_P}.zip"
HOMEPAGE="http://www.oasis-open.org/docbook/sgml/${PV}/index.html"
LICENSE="X11"

SLOT="4.2"
IUSE=""
KEYWORDS="x86 ~ppc sparc alpha hppa ia64"

DEPEND=">=app-arch/unzip-5.41"
RDEPEND="app-text/sgml-common"

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${A}
	cp ${FILESDIR}/${P}.Makefile Makefile
	patch -b docbook.cat ${FILESDIR}/${P}-catalog.diff || die
}

sgml-catalog_cat_include "/etc/sgml/sgml-docbook-${PV}.cat" \
	"/usr/share/sgml/docbook/sgml-dtd-${PV}/catalog"
sgml-catalog_cat_include "/etc/sgml/sgml-docbook-${PV}.cat" \
	"/etc/sgml/sgml-docbook.cat"

src_install () {

	make DESTDIR=${D}/usr/share/sgml/docbook/sgml-dtd-${PV} install || die
	dodoc ChangeLog README
}
