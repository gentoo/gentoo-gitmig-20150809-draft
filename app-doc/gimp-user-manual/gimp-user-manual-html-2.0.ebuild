# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-doc/gimp-user-manual/gimp-user-manual-html-2.0.ebuild,v 1.1 2000/10/10 17:42:05 achim Exp $

A="GimpUsersManual_SecondEdition-HTML_Search.tar.gz
   GimpUsersManual_SecondEdition-HTML_Color.tar.gz"

S=${WORKDIR}/${P}
DESCRIPTION="A user manual for GIMP"
SRC_URI="ftp://manual.gimp.org/pub/manual/GimpUsersManual_SecondEdition-HTML_Search.tar.gz
	 ftp://manual.gimp.org/pub/manual/GimpUsersManual_SecondEdition-HTML_Color.tar.gz"
HOMEPAGE="http://manual.gimp.org"


src_unpack() {

  mkdir ${S}
  cd ${S}
  unpack ${A}

}

src_compile() {

    cd ${S}
    rm GUM/wwhsrch.js
    touch GUM/wwhsrch.js

}

src_install () {

   dodir /usr/doc/${P}/html
   cp -a ${S}/GUM ${D}/usr/doc/${P}/html
   cp -a ${S}/GUMC ${D}/usr/doc/${P}/html
   dodoc README_NOW

}

