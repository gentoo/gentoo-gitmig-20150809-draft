# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xapian/xapian-1.2.4.ebuild,v 1.2 2011/01/26 18:33:45 hwoarang Exp $

EAPI="3"

MY_P="${PN}-core-${PV}"

DESCRIPTION="Xapian Probabilistic Information Retrieval library"
HOMEPAGE="http://www.xapian.org/"
SRC_URI="http://oligarchy.co.uk/xapian/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"

	mv "${D}usr/share/doc/xapian-core" "${D}usr/share/doc/${PF}"

	dodoc AUTHORS HACKING PLATFORMS README NEWS || die "dodoc failed"
}
