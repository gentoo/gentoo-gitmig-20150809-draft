# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-doc/gimp-user-manual/gimp-user-manual-2.0.ebuild,v 1.4 2002/07/11 06:30:11 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A user manual for GIMP"
SRC_URI="ftp://manual.gimp.org/pub/manual/GimpUsersManual_SecondEdition-HTML_Search.tar.gz
	 ftp://manual.gimp.org/pub/manual/GimpUsersManual_SecondEdition-HTML_Color.tar.gz"
HOMEPAGE="http://manual.gimp.org"
DEPEND=""


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

   dodir /usr/share/doc/${PF}/html
   cp -a ${S}/GUM ${D}/usr/share/doc/${PF}/html
   cp -a ${S}/GUMC ${D}/usr/share/doc/${PF}/html
   dodoc README_NOW
}

