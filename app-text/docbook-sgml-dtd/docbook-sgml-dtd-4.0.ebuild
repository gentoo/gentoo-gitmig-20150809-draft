# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-sgml-dtd/docbook-sgml-dtd-4.0.ebuild,v 1.2 2001/06/08 01:08:06 achim Exp $

A="docbk40.zip"
S=${WORKDIR}/${P}
DESCRIPTION="Docbook SGML DTD 4.0"
SRC_URI="http://www.oasis-open.org/docbook/sgml/${PV}/${A}"

HOMEPAGE="http://www.oasis-open.org/docbook/sgml/${PV}/index.html"

DEPEND=">=app-arch/unzip-5.41"
RDEPEND="app-text/sgml-common"

src_unpack() {
  mkdir ${S}
  cd ${S}
  unpack ${A}
  cp ${FILESDIR}/${P}.Makefile Makefile
  patch -b docbook.cat ${FILESDIR}/${P}-catalog.diff
}

src_install () {

    try make DESTDIR=${D}/usr/share/sgml/docbook/sgml-dtd-${PV} install
    dodoc *.txt
}

pkg_postinst() {
  if [ -x  "/usr/bin/install-catalog" ] && [ "$ROOT" = "/" ] ; then
    install-catalog --add /etc/sgml/sgml-docbook-${PV}.cat  /usr/share/sgml/docbook/sgml-dtd-${PV}/catalog
    install-catalog --add /etc/sgml/sgml-docbook-${PV}.cat /etc/sgml/sgml-docbook.cat
  fi
}
pkg_prerm() {
  if [ -x  "/usr/bin/install-catalog" ] && [ "$ROOT" = "/" ] ; then
    install-catalog --remove /etc/sgml/sgml-docbook-${PV}.cat /usr/share/sgml/docbook/sgml-dtd-${PV}/catalog
    install-catalog --remove /etc/sgml/sgml-docbook-${PV}.cat /etc/sgml/sgml-docbook.cat
  fi
}
