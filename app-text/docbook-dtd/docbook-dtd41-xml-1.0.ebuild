# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-dtd/docbook-dtd41-xml-1.0.ebuild,v 1.1 2001/03/06 06:20:41 achim Exp $

A="docbkx41.zip ${P}.catalog.patch ${P}.dbcentx.patch ${P}.Makefile"
S=${WORKDIR}/${P}
DESCRIPTION="Docbook DTD"
SRC_URI="ftp://ftp.kde.org/pub/kde/devel/docbook/SOURCES/docbkx41.zip
	 ftp://ftp.kde.org/pub/kde/devel/docbook/SOURCES/${P}.catalog.patch
     ftp://ftp.kde.org/pub/kde/devel/docbook/SOURCES/${P}.dbcentx.patch
	 ftp://ftp.kde.org/pub/kde/devel/docbook/SOURCES/${P}.Makefile"

HOMEPAGE="http://www.oasis-open.org/docbook/"

DEPEND=">=app-arch/unzip-5.41"

src_unpack() {
  mkdir ${S}
  cd ${S}
  unpack docbkx41.zip
  cp ${DISTDIR}/${P}.Makefile Makefile
  patch -b docbook.cat ${DISTDIR}/${P}.catalog.patch
  patch -b dbcentx.mod ${DISTDIR}/${P}.dbcentx.patch
}
src_install() {

    try make DESTDIR=${D}/usr/share/sgml/docbook/sgml-xml-4.1 install

}

