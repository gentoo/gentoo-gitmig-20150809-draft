# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-style-dsssl/docbook-style-dsssl-1.57.ebuild,v 1.2 2000/11/02 02:17:12 achim Exp $

A="db157.zip ${P}.Makefile"
S=${WORKDIR}/docbook
DESCRIPTION=""
SRC_URI="http://www.nwalsh.com/docbook/dsssl/db157.zip
	 ftp://ftp.kde.org/pub/kde/devel/docbook/SOURCES/${P}.Makefile"
HOMEPAGE="http://www.nwalsh.com/docbook/dsssl/"

DEPEND=">=app-arch/unzip-5.41"

src_unpack() {
  unpack db157.zip
  cp ${DISTDIR}/${P}.Makefile ${S}/Makefile
}

src_compile() {

    cd ${S}

}

src_install () {

    cd ${S}
    try make DESTDIR=${D}/usr/share/sgml/docbook/dsssl-stylesheets-${PV} install

}

