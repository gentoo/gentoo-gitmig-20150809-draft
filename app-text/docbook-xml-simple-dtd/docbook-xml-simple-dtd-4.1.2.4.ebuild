# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-xml-simple-dtd/docbook-xml-simple-dtd-4.1.2.4.ebuild,v 1.1 2001/03/20 05:53:12 achim Exp $

A="sdb4124.zip"
S=${WORKDIR}/${P}
DESCRIPTION="Docbook DTD for XML"
SRC_URI="http://www.nwalsh.com/docbook/simple/${PV}/${A}"

HOMEPAGE="http://www.oasis-open.org/docbook/"

DEPEND=">=app-arch/unzip-5.41"

src_unpack() {
  mkdir ${S}
  cd ${S}
  unpack ${A}
}

src_install() {

    insinto /usr/share/sgml/docbook/xml-simple-dtd-${PV}
    doins *.dtd *.mod *.css
    newins ${FILESDIR}/${P}.catalog catalog
    insinto /usr/share/sgml/docbook/xml-simple-dtd-${PV}/ent
    doins ent/*.ent
    
    dodoc README ChangeLog LostLog COPYRIGHT
}

pkg_postinst() {
    install-catalog --add /etc/sgml/xml-docbook.cat /usr/share/sgml/docbook/xml-simple-dtd-${PV}/catalog
    install-catalog --add /etc/sgml/xml-simple-docbook-${PV}.cat /usr/share/sgml/docbook/xml-simple-dtd-${PV}/catalog
}

pkg_prerm() {
    install-catalog --remove /etc/sgml/xml-docbook.cat /usr/share/sgml/docbook/xml-simple-dtd-${PV}/catalog
    install-catalog --remove /etc/sgml/xml-simple-docbook-${PV}.cat /usr/share/sgml/docbook/xml-simple-dtd-${PV}/catalog
}
