# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/pktstat/pktstat-1.7.2q.ebuild,v 1.3 2004/07/10 11:45:51 eldad Exp $

DESCRIPTION="A network monitoring tool, with bandwidth tracking"
#SRC_URI="http://www.itee.uq.edu.au/~leonard/personal/software/${P}.tar.gz"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://www.itee.uq.edu.au/~leonard/personal/software/#pktstat"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=net-libs/libpcap-0.7.2
	>=sys-libs/ncurses-5.3-r1"

src_compile() {
	#Package doesn't use autoconf
	emake || die
}

src_install() {
	dosbin pktstat
	doman pktstat.1
	dodoc README
}
