# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-xml-simple-dtd/docbook-xml-simple-dtd-4.1.2.4.ebuild,v 1.25 2006/07/05 06:54:42 vapier Exp $

MY_P="sdb4124"
DESCRIPTION="Docbook DTD for XML"
HOMEPAGE="http://www.oasis-open.org/docbook/"
SRC_URI="http://www.nwalsh.com/docbook/simple/${PV}/${MY_P}.zip"

LICENSE="X11"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=">=app-arch/unzip-5.41"

src_unpack() {
	mkdir -p "${S}"
	cd "${S}"
	unpack ${A}
}

src_install() {
	insinto /usr/share/sgml/docbook/xml-simple-dtd-${PV}
	doins *.dtd *.mod *.css

	#newins ${FILESDIR}/${P}.catalog catalog

	insinto /usr/share/sgml/docbook/xml-simple-dtd-${PV}/ent
	doins ent/*.ent

	dodoc README ChangeLog LostLog COPYRIGHT
}
