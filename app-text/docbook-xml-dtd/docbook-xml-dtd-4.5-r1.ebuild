# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-xml-dtd/docbook-xml-dtd-4.5-r1.ebuild,v 1.3 2010/02/11 14:51:39 ulm Exp $

inherit sgml-catalog

MY_P=${P/-dtd/}
DESCRIPTION="Docbook DTD for XML"
HOMEPAGE="http://www.docbook.org/"
SRC_URI="http://www.docbook.org/xml/${PV}/${MY_P}.zip"

LICENSE="as-is"
SLOT="${PV}"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND=""
DEPEND=">=app-arch/unzip-5.41
	>=dev-libs/libxml2-2.4
	>=app-text/docbook-xsl-stylesheets-1.65
	>=app-text/build-docbook-catalog-1.2"

sgml-catalog_cat_include "/etc/sgml/xml-docbook-${PV}.cat" \
	"/etc/sgml/sgml-docbook.cat"
sgml-catalog_cat_include "/etc/sgml/xml-docbook-${PV}.cat" \
	"/usr/share/sgml/docbook/xml-dtd-${PV}/docbook.cat"

S=${WORKDIR}

src_unpack() {
	unpack ${A}

	# Prepend OVERRIDE directive
	sed -i -e '1i\\OVERRIDE YES' docbook.cat
}

src_install() {
	keepdir /etc/xml

	insinto /usr/share/sgml/docbook/xml-dtd-${PV}
	doins *.cat *.dtd *.mod *.xml || die
	insinto /usr/share/sgml/docbook/xml-dtd-${PV}/ent
	doins ent/*.ent || die

	# work around unicode parser issues #238785
	dosym ../../../xml-iso-entities-8879.1986/ISOgrk4.ent \
		/usr/share/sgml/docbook/xml-dtd-${PV}/ent/isogrk4.ent || die

	cp ent/README README.ent
	dodoc ChangeLog README*
}

pkg_postinst() {
	build-docbook-catalog
	sgml-catalog_pkg_postinst
}

pkg_postrm() {
	build-docbook-catalog
	sgml-catalog_pkg_postrm
}
