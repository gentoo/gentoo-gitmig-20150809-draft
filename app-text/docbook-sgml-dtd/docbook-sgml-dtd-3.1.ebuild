# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-sgml-dtd/docbook-sgml-dtd-3.1.ebuild,v 1.6 2002/07/16 03:44:51 owen Exp $

MY_P="docbk31"
S=${WORKDIR}/${P}
DESCRIPTION="Docbook SGML DTD 3.1"
SRC_URI="http://www.oasis-open.org/docbook/sgml/${PV}/${MY_P}.zip"

HOMEPAGE="http://www.oasis-open.org/docbook/sgml/${PV}/index.html"

DEPEND=">=app-arch/unzip-5.41"
RDEPEND="app-text/sgml-common"

SLOT="3.1"

KEYWORDS="x86 ppc"
src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${A}
	cp ${FILESDIR}/${P}.Makefile Makefile
	patch -b docbook.cat ${FILESDIR}/${P}-catalog.diff
}

src_install () {

	 make DESTDIR=${D}/usr/share/sgml/docbook/sgml-dtd-${PV} install || die
	 dodoc *.txt
}

pkg_postinst() {
	if [ -x  "/usr/bin/install-catalog" ] && [ "$ROOT" = "/" ]
	then
		install-catalog --add \
			/etc/sgml/sgml-docbook-${PV}.cat \
			/usr/share/sgml/docbook/sgml-dtd-${PV}/catalog
			
		install-catalog --add \
			/etc/sgml/sgml-docbook-${PV}.cat \
			/etc/sgml/sgml-docbook.cat
	fi
}
