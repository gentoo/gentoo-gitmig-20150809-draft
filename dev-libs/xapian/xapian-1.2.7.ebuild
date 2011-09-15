# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xapian/xapian-1.2.7.ebuild,v 1.1 2011/09/15 11:26:46 blueness Exp $

EAPI=4

MY_P="${PN}-core-${PV}"

DESCRIPTION="Xapian Probabilistic Information Retrieval library"
HOMEPAGE="http://www.xapian.org/"
SRC_URI="http://oligarchy.co.uk/xapian/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install

	if use doc; then
		mv "${D}usr/share/doc/xapian-core" "${D}usr/share/doc/${PF}"
	fi

	dodoc AUTHORS HACKING PLATFORMS README NEWS
}

src_test() {
	emake check VALGRIND=
}
