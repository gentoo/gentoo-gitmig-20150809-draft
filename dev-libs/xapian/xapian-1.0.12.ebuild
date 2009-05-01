# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xapian/xapian-1.0.12.ebuild,v 1.1 2009/05/01 19:25:00 gengor Exp $

MY_P="${PN}-core-${PV}"

DESCRIPTION="Xapian Probabilistic Information Retrieval library"
HOMEPAGE="http://www.xapian.org/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz
	http://www.oligarchy.co.uk/xapian/${PV}/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="sys-devel/libtool"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_install () {
	emake DESTDIR="${D}" install || die

	mv "${D}/usr/share/doc/xapian-core" "${D}/usr/share/doc/${PF}"

	dodoc AUTHORS HACKING PLATFORMS README NEWS || die "dodoc failed"
}
