# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-sgml-dtd/docbook-sgml-dtd-4.1-r1.ebuild,v 1.12 2004/10/17 11:52:35 usata Exp $

inherit sgml-catalog

MY_P="docbk41"
DESCRIPTION="Docbook SGML DTD 4.1"
HOMEPAGE="http://www.oasis-open.org/docbook/sgml/${PV}/index.html"
SRC_URI="http://www.oasis-open.org/docbook/sgml/${PV}/${MY_P}.zip"

LICENSE="X11"
SLOT="4.1"
KEYWORDS="alpha arm amd64 hppa ia64 mips ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=app-arch/unzip-5.41"
RDEPEND="app-text/sgml-common"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	patch -b docbook.cat ${FILESDIR}/${P}-catalog.diff || die
}

sgml-catalog_cat_include "/etc/sgml/sgml-docbook-${PV}.cat" \
	"/usr/share/sgml/docbook/sgml-dtd-${PV}/catalog"
sgml-catalog_cat_include "/etc/sgml/sgml-docbook-${PV}.cat" \
	"/etc/sgml/sgml-docbook.cat"

src_install () {
	insinto /usr/share/sgml/docbook/sgml-dtd-${PV}
	doins *.dcl *.dtd *.mod
	insinto /usr/share/sgml/docbook/sgml-dtd-${PV}/catalog
	doins docbook.cat

	dodoc *.txt
}
