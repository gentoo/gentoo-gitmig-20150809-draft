# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

#IUSE="nls"

S=${WORKDIR}/${P}
DESCRIPTION="a small stealth network autoconfigure software."
SRC_URI="mirror://sourceforge/selfdhcp/${P}.tar.bz2"
HOMEPAGE="http://selfdhcp.sourceforge.net"
KEYWORDS="~x86 ~sparc ~ppc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="dev-libs/popt
		dev-libs/libxml2
		>=net-libs/libnet-1.0.2
		>=net-libs/libpcap-0.7"

src_compile() {

	./configure --prefix=/usr \
		--disable-nls || die

	emake || die
}

src_install() {
	make prefix=${D}/usr install || die

	dodoc README AUTHORS TODO THANKS BUGS NEW COPYING ChangeLog
	}
