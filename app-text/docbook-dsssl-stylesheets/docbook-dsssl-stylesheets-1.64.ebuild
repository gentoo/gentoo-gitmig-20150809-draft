# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-dsssl-stylesheets/docbook-dsssl-stylesheets-1.64.ebuild,v 1.1 2001/03/20 05:53:12 achim Exp $

A="db164.zip"
S=${WORKDIR}/docbook
DESCRIPTION=""
SRC_URI="http://www.nwalsh.com/docbook/dsssl/${A}"
HOMEPAGE="http://www.nwalsh.com/docbook/dsssl/"

DEPEND=">=app-arch/unzip-5.41
                app-text/sgml-common"

src_unpack() {

  unpack ${A}
  cp ${FILESDIR}/${P}.Makefile ${S}/Makefile

}

src_install () {

    try make DESTDIR=${D}/usr/share/sgml/docbook/dsssl-stylesheets-${PV} install

}

pkg_postinst() {
    install-catalog --add /etc/sgml/dsssl-docbook-stylesheets.cat /usr/share/sgml/docbook/dsssl-stylesheets-${PV}/catalog
    install-catalog --add /etc/sgml/sgml-docbook.cat /etc/sgml/dsssl-docbook-stylesheets.cat
}

pkg_prerm() {
    install-catalog --remove /etc/sgml/dsssl-docbook-stylesheets.cat /usr/share/sgml/docbook/dsssl-stylesheets-${PV}/catalog
    install-catalog --remove /etc/sgml/sgml-docbook.cat /etc/sgml/dsssl-docbook-stylesheets.cat
}
