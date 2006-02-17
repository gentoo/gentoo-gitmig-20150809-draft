# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcptrack/tcptrack-1.1.5.ebuild,v 1.3 2006/02/17 16:20:59 jokey Exp $

IUSE=""

DESCRIPTION="Passive per-connection tcp bandwidth monitor"
SRC_URI="http://www.rhythm.cx/~steve/devel/tcptrack/release/${PV}/source/${P}.tar.gz"
HOMEPAGE="http://www.rhythm.cx/~steve/devel/tcptrack/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"

newdepend "net-libs/libpcap
	   sys-libs/ncurses"

src_install() {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
