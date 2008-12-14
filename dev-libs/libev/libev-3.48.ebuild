# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libev/libev-3.48.ebuild,v 1.2 2008/12/14 15:50:51 gentoofan23 Exp $

inherit autotools eutils

DESCRIPTION="A high-performance event loop/event model with lots of feature"
HOMEPAGE="http://software.schmorp.de/pkg/libev.html"
SRC_URI="http://dist.schmorp.de/libev/${P}.tar.gz"

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-3.42-gentoo.patch"

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc Changes README
}
