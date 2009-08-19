# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libev/libev-3.80.ebuild,v 1.1 2009/08/19 16:38:41 matsuu Exp $

inherit autotools eutils

MY_P="${P/0}"
DESCRIPTION="A high-performance event loop/event model with lots of feature"
HOMEPAGE="http://software.schmorp.de/pkg/libev.html"
SRC_URI="http://dist.schmorp.de/libev/${MY_P}.tar.gz
	http://dist.schmorp.de/libev/${MY_P}.tar.gz"

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}/${MY_P}"

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
