# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-doc/gentoo-doc/gentoo-doc-1.0_rc4.ebuild,v 1.2 2001/03/25 15:44:28 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The Gentoo-Linux Documentation"
HOMEPAGE="http://www.gentoo.org"

DEPEND="virtual/glibc
                app-text/tetex
                app-text/openjade
                =app-text/docbook-sgml-dtd-4.1
                app-text/docbook-dsssl-stylesheets
                app-text/docbook-sgml-utils"

src_unpack () {
    mkdir ${S}
}

src_compile() {

  mkdir html
  cd html
  try docbook2html ${FILESDIR}/gentoo.sgml
  cd ..
  mkdir print
  cd print
  mkdir images
  cp -a ${FILESDIR}/images/*.eps images
  try docbook2dvi ${FILESDIR}/gentoo.sgml
  try dvips -o gentoo.ps gentoo.dvi
  try ps2pdf gentoo.ps
  cd ..
  mkdir man
  cd man
  try docbook2man ${FILESDIR}/gentoo.sgml

}

src_install () {

    dodir /usr/share/doc/${PF}/print
    cp -a html ${D}/usr/share/doc/${PF}
    insinto /usr/share/doc/${PF}/html/images
    doins ${FILESDIR}/images/*.png
    insinto /usr/share/doc/${PF}/images
    doins ${FILESDIR}/images-dsssl/*.gif
    insinto /usr/share/doc/${PF}/print/images
    doins ${FILESDIR}/images/*.eps
    cp -a print/gentoo.{dvi,ps,pdf} ${D}/usr/share/doc/${PF}/print
    doman man/*.[1-8]
}

