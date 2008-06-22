# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libev/libev-3.42-r1.ebuild,v 1.1 2008/06/22 00:49:26 matsuu Exp $

inherit autotools eutils

DESCRIPTION="A high-performance event loop/event model with lots of feature"
HOMEPAGE="http://software.schmorp.de/pkg/libev"
SRC_URI="http://dist.schmorp.de/libev/${P}.tar.gz"

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.patch"

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc Changes README
}
