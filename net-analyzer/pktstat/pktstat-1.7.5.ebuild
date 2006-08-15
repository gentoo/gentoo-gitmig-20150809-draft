# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/pktstat/pktstat-1.7.5.ebuild,v 1.7 2006/08/15 09:13:16 blubb Exp $

DESCRIPTION="A network monitoring tool, with bandwidth tracking"
SRC_URI="http://www.adaptive-enterprises.com.au/~d/software/pktstat/${P}.tar.gz"
HOMEPAGE="http://www.adaptive-enterprises.com.au/~d/software/pktstat/"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="net-libs/libpcap
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
