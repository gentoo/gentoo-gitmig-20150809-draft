# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/paketto/paketto-1.0.ebuild,v 1.2 2003/02/13 13:49:37 vapier Exp $

DESCRIPTION="Paketto Keiretsu - experimental TCP/IP tools - scanrand, minewt, lc, phentropy, paratrace"
HOMEPAGE="http://www.doxpara.com/"
SRC_URI="http://www.doxpara.com/paketto/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
IUSE="pic"

#paketto comes with local copies of these ...
#DEPEND="net-libs/libpcap
#	net-libs/libnet
#	dev-libs/libtomcrypt"

src_compile() {
	# --with-libnet-bin=/usr --with-pcap-lib=/usr --with-pcap-inc=/usr --with-tm-inc=/usr"
	local myconf="--with-gnu-ld"
	use pic && myconf="${myconf} --with-pic"

	econf
	emake || die
}

src_install() {
	einstall
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
	dodoc docs/lc_logs.txt docs/minewt_logs.txt docs/paratrace_logs.txt docs/scanrand_logs.txt
}
