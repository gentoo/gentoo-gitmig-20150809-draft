# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fragroute/fragroute-1.2-r2.ebuild,v 1.1 2010/10/27 02:58:32 jer Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="Testing of network intrusion detection systems, firewalls and TCP/IP stacks"
HOMEPAGE="http://www.monkey.org/~dugsong/fragroute/"
SRC_URI="http://www.monkey.org/~dugsong/fragroute/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="
	dev-libs/libevent[static-libs]
	net-libs/libpcap
	>=dev-libs/libdnet-1.4"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-libevent.patch
	tc-export CC
}

src_configure() {
	econf --with-libevent="${EPREFIX}"/usr --with-libdnet="${EPREFIX}"/usr
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README || die
}
