# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-xml/docbook-xml-4.1.2.ebuild,v 1.1 2001/03/17 18:50:41 achim Exp $

A="docbkx412.zip"
S=${WORKDIR}/${P}
DESCRIPTION="Docbook DTD for XML"
SRC_URI="http://www.oasis-open.org/docbook/xml/4.1.2/${A}"

HOMEPAGE="http://www.oasis-open.org/docbook/"

DEPEND=">=app-arch/unzip-5.41"

src_unpack() {
  mkdir ${S}
  cd ${S}
  unpack ${A}
}

src_install() {

    insinto /usr/share/sgml/docbook/xml/4.1.2
    doins *.dtd *.mod 
    newins docbook.cat catalog
    insinto /usr/share/sgml/docbook/xml/4.1.2/ent
    doins ent/*.ent

    dodoc ChangeLog *.txt
}

