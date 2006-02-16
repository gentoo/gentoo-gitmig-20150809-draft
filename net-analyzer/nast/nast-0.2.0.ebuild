# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nast/nast-0.2.0.ebuild,v 1.7 2006/02/15 23:25:23 jokey Exp $

DESCRIPTION="NAST - Network Analyzer Sniffer Tool"
HOMEPAGE="http://nast.berlios.de/"
SRC_URI="http://nast.berlios.de/src/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="ncurses"

DEPEND=">=net-libs/libnet-1.1.1
	net-libs/libpcap
	ncurses? ( >=sys-libs/ncurses-5.4 )"

src_compile() {
	econf || die "econf failed"
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dosbin nast
	doman nast.8
	dodoc AUTHORS BUGS COPYING CREDITS ChangeLog NCURSES_README README TODO
}
