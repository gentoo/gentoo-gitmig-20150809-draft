# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-xml-dtd/docbook-xml-dtd-4.1.2-r2.ebuild,v 1.11 2003/09/05 22:37:21 msterret Exp $

MY_P="docbkx412"
S=${WORKDIR}/${P}
DESCRIPTION="Docbook DTD for XML"
SRC_URI="http://www.oasis-open.org/docbook/xml/${PV}/${MY_P}.zip"

HOMEPAGE="http://www.oasis-open.org/docbook/"
SLOT="4.1.2"
LICENSE="X11"

DEPEND=">=app-arch/unzip-5.41
	>=dev-libs/libxml2-2.4
	>=app-text/docbook-xsl-stylesheets-1.45"
KEYWORDS="x86 ppc sparc "
src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${A}
}

src_install() {

	newbin ${FILESDIR}/build-docbook-catalog-${PV} build-docbook-catalog

	dodir /etc/xml
	touch ${D}/etc/xml/.keep

	insinto /usr/share/xml/docbook/xml-dtd-${PV}
	doins *.dtd *.mod
	doins docbook.cat
	insinto /usr/share/xml/docbook/xml-dtd-${PV}/ent
	doins ent/*.ent

	dodoc ChangeLog *.txt
}

pkg_postinst() {
	build-docbook-catalog
}
