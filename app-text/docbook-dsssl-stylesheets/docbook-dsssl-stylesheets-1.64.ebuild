# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-dsssl-stylesheets/docbook-dsssl-stylesheets-1.64.ebuild,v 1.5 2002/04/28 20:28:54 drobbins Exp $

MY_P="db164"
S=${WORKDIR}/docbook
DESCRIPTION=""
SRC_URI="http://www.nwalsh.com/docbook/dsssl/${MY_P}.zip"
HOMEPAGE="http://www.nwalsh.com/docbook/dsssl/"

DEPEND=">=app-arch/unzip-5.41"
RDEPEND="app-text/sgml-common"

src_install () {

	cp ${FILESDIR}/${P}.Makefile Makefile

	make \
		BINDIR="${D}/usr/bin" \
		DESTDIR="${D}/usr/share/sgml/docbook/dsssl-stylesheets-${PV}" \
		install || die

}

pkg_postinst() {
	if [ -x  "/usr/bin/install-catalog" ] && [ "$ROOT" = "/" ]
	then
		install-catalog --add \
			/etc/sgml/dsssl-docbook-stylesheets.cat \
			/usr/share/sgml/docbook/dsssl-stylesheets-${PV}/catalog

		install-catalog --add \
			/etc/sgml/sgml-docbook.cat \
			/etc/sgml/dsssl-docbook-stylesheets.cat
	fi
}

pkg_prerm() {
	if [ -x  "/usr/bin/install-catalog" ] && [ "$ROOT" = "/" ]
	then
		install-catalog --remove \
			/etc/sgml/dsssl-docbook-stylesheets.cat \
			/usr/share/sgml/docbook/dsssl-stylesheets-${PV}/catalog
		install-catalog --remove \
			/etc/sgml/sgml-docbook.cat \
			/etc/sgml/dsssl-docbook-stylesheets.cat
	fi
}
