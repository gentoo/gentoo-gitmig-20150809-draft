# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-dsssl-stylesheets/docbook-dsssl-stylesheets-1.64.ebuild,v 1.2 2001/06/08 01:08:06 achim Exp $

A="db164.zip"
S=${WORKDIR}/docbook
DESCRIPTION=""
SRC_URI="http://www.nwalsh.com/docbook/dsssl/${A}"
HOMEPAGE="http://www.nwalsh.com/docbook/dsssl/"

DEPEND=">=app-arch/unzip-5.41"
RDEPEND="app-text/sgml-common"

src_unpack() {

  unpack ${A}
  cp ${FILESDIR}/${P}.Makefile ${S}/Makefile

}

src_install () {

    try make DESTDIR=${D}/usr/share/sgml/docbook/dsssl-stylesheets-${PV} install

}

pkg_postinst() {
  if [ -x  "/usr/bin/install-catalog" ] && [ "$ROOT" = "/" ] ; then
    install-catalog --add /etc/sgml/dsssl-docbook-stylesheets.cat /usr/share/sgml/docbook/dsssl-stylesheets-${PV}/catalog
    install-catalog --add /etc/sgml/sgml-docbook.cat /etc/sgml/dsssl-docbook-stylesheets.cat
  fi
}

pkg_prerm() {
  if [ -x  "/usr/bin/install-catalog" ] && [ "$ROOT" = "/" ] ; then
    install-catalog --remove /etc/sgml/dsssl-docbook-stylesheets.cat /usr/share/sgml/docbook/dsssl-stylesheets-${PV}/catalog
    install-catalog --remove /etc/sgml/sgml-docbook.cat /etc/sgml/dsssl-docbook-stylesheets.cat
  fi
}
