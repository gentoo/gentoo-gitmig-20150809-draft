# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-xml-dtd/docbook-xml-dtd-4.1.2-r3.ebuild,v 1.1 2002/08/16 19:38:48 satai Exp $

MY_P="docbkx412"
S=${WORKDIR}/${P}
DESCRIPTION="Docbook DTD for XML"
SRC_URI="http://www.oasis-open.org/docbook/xml/${PV}/${MY_P}.zip"

HOMEPAGE="http://www.oasis-open.org/docbook/"
SLOT="0"
LICENSE="X11"

DEPEND=">=app-arch/unzip-5.41
	>=dev-libs/libxml2-2.4
	>=app-text/docbook-xsl-stylesheets-1.45"
KEYWORDS="x86 ppc sparc sparc64"
src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${A}
}

src_install() {

	newbin ${FILESDIR}/build-docbook-catalog-${PV}-r3 build-docbook-catalog

	dodir /etc/xml
	touch ${D}/etc/sml/.keep

	insinto /usr/share/sgml/docbook/xml-dtd-${PV}
	doins *.dtd *.mod
	doins docbook.cat 
	insinto /usr/share/sgml/docbook/xml-dtd-${PV}/ent
	doins ent/*.ent

	dodoc ChangeLog *.txt
}

pkg_postinst() {
	build-docbook-catalog
}	
