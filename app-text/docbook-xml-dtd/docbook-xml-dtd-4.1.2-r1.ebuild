# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Tools Team <tools@gentoo.org>
# Author: Achim Gottinger <achim@gentoo.org>
# Author: Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-xml-dtd/docbook-xml-dtd-4.1.2-r1.ebuild,v 1.1 2002/02/24 03:01:02 karltk Exp $

A="docbkx412.zip"
S=${WORKDIR}/${P}
DESCRIPTION="Docbook DTD for XML"
SRC_URI="http://www.oasis-open.org/docbook/xml/${PV}/${A}"

HOMEPAGE="http://www.oasis-open.org/docbook/"

DEPEND=">=app-arch/unzip-5.41
	>=dev-libs/libxml2-2.4"
RDEPEND="" 

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${A}
}

src_install() {

	dodir /etc/xml
	dosym /etc/xml/xml-docbook.cat /etc/xml/catalog

	insinto /usr/share/sgml/docbook/xml-dtd-${PV}
	doins *.dtd *.mod
	doins docbook.cat 
	insinto /usr/share/sgml/docbook/xml-dtd-${PV}/ent
	doins ent/*.ent

	dodoc ChangeLog *.txt
}

pkg_postinst() {
	install-catalog --add /etc/xml/xml-docbook-${PV}.cat \
		 /usr/share/sgml/docbook/xml-dtd-${PV}/docbook.cat
	install-catalog --add /etc/xml/xml-docbook.cat \
		/etc/xml/xml-docbook-${PV}.cat
}	

pkg_prerm() {
	install-catalog --remove /etc/xml/xml-docbook-${PV}.cat \
		 /usr/share/sgml/docbook/xml-dtd-${PV}/docbook.cat
	install-catalog --remove /etc/xml/xml-docbook.cat \
		/etc/xml/xml-docbook-${PV}.cat
}	
