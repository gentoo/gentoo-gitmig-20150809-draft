# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-xml-simplified/docbook-xml-simplified-4.1.2.4.ebuild,v 1.1 2001/03/17 19:57:02 achim Exp $

A="sdb4124.zip"
S=${WORKDIR}/${P}
DESCRIPTION="Docbook DTD for XML"
SRC_URI="http://www.nwalsh.com/docbook/simple/4.1.2.4/${A}"

HOMEPAGE="http://www.oasis-open.org/docbook/"

DEPEND=">=app-arch/unzip-5.41"

src_unpack() {
  mkdir ${S}
  cd ${S}
  unpack ${A}
}

src_install() {

    insinto /usr/share/sgml/docbook/simplified/4.1.2.4
    doins *.dtd *.mod *.css
    insinto /usr/share/sgml/docbook/simplified/4.1.2.4/ent
    doins ent/*.ent

    dodoc README ChangeLog LostLog COPYRIGHT *.txt
}

