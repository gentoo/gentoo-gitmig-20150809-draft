# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ftester/ftester-0.8.ebuild,v 1.6 2004/07/09 20:11:46 eldad Exp $

DESCRIPTION="Ftester - Firewall and Intrusion Detection System testing tool"
HOMEPAGE="http://ftester.sourceforge.net
	http://www.infis.univ.trieste.it/~lcars/ftester"
SRC_URI="http://ftester.sourceforge.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="dev-perl/Net-RawIP
	dev-perl/NetPacket
	dev-perl/Net-Pcap
	dev-perl/Net-PcapUtils"

src_install() {
	dodoc COPYING CREDITS Changelog LICENSE ftest.conf
	doman ftester.8
	dosbin ftestd ftest freport
}
