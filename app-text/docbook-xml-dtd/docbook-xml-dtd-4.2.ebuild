# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-xml-dtd/docbook-xml-dtd-4.2.ebuild,v 1.23 2004/07/29 01:51:53 tgall Exp $

MY_P="docbook-xml-4.2"
DESCRIPTION="Docbook DTD for XML"
HOMEPAGE="http://www.oasis-open.org/docbook/"
SRC_URI="http://www.oasis-open.org/docbook/xml/${PV}/${MY_P}.zip"

LICENSE="X11"
SLOT="4.2"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 s390 ppc64"
IUSE=""

DEPEND=">=app-arch/unzip-5.41
	>=dev-libs/libxml2-2.4
	>=app-text/docbook-xsl-stylesheets-1.45"

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${A}
}

src_install() {
	newbin ${FILESDIR}/build-docbook-catalog-${PV} build-docbook-catalog

	keepdir /etc/xml

	insinto /usr/share/sgml/docbook/xml-dtd-${PV}
	doins *.dtd *.mod
	doins docbook.cat
	insinto /usr/share/sgml/docbook/xml-dtd-${PV}/ent
	doins ent/*.ent

	dodoc ChangeLog README
}

pkg_postinst() {
	# FIXME: this script needs to work with 4.2 as well as 4.1.2
	build-docbook-catalog

	# we need to add the docbookx.dtd to local, so
	# packages that refer to it dont need to go http
	# for it <obz@gentoo.org>
	CATALOG=/etc/xml/catalog

	/usr/bin/xmlcatalog --noout --add "rewriteSystem" \
		"http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd" \
		"/usr/share/sgml/docbook/xml-dtd-4.2/docbookx.dtd" \
		${CATALOG}

	/usr/bin/xmlcatalog --noout --add "rewriteURI" \
		"http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd" \
		"/usr/share/sgml/docbook/xml-dtd-4.2/docbookx.dtd" \
		${CATALOG}
}

pkg_postrm() {
	# and clean up the docbookx.dtd once we've been removed
	CATALOG=/etc/xml/catalog
	/usr/bin/xmlcatalog --noout --del \
		"/usr/share/sgml/docbook/xml-dtd-4.2/docbookx.dtd" \
		${CATALOG}

}
