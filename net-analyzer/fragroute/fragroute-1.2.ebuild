# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fragroute/fragroute-1.2.ebuild,v 1.2 2003/09/04 07:44:30 msterret Exp $

DESCRIPTION="fragroute was written to aid in the testing of network intrusion detection systems, firewalls and basic TCP/IP stack behaviour."
HOMEPAGE="http://www.monkey.org/~dugsong/fragroute/"
SRC_URI="http://www.monkey.org/~dugsong/fragroute/${P}.tar.gz"
LICENSE="DSNIFF"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/glibc
		>=dev-libs/libevent-0.6
		>=net-libs/libpcap-0.7.2
		>=dev-libs/libdnet-1.4"
RDEPEND=""
S=${WORKDIR}/${P}

src_compile() {
	econf --with-libevent=/usr --with-libdnet=/usr || die "Econf failed"
	emake || die "Make failed"
}

src_install() {
	einstall || die
	dodoc README
}
