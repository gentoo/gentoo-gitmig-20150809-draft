# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fragroute/fragroute-1.2.ebuild,v 1.12 2009/09/23 18:18:32 patrick Exp $

DESCRIPTION="fragroute was written to aid in the testing of network intrusion detection systems, firewalls and basic TCP/IP stack behaviour."
HOMEPAGE="http://www.monkey.org/~dugsong/fragroute/"
SRC_URI="http://www.monkey.org/~dugsong/fragroute/${P}.tar.gz"
LICENSE="DSNIFF"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""
DEPEND=">=dev-libs/libevent-0.6
	net-libs/libpcap
	>=dev-libs/libdnet-1.4"

src_compile() {
	econf --with-libevent=/usr --with-libdnet=/usr || die "Econf failed"
	emake || die "Make failed"
}

src_install() {
	einstall || die
	dodoc README
}
