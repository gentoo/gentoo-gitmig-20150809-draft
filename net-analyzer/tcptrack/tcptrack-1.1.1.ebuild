# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcptrack/tcptrack-1.1.1.ebuild,v 1.4 2005/01/29 05:12:51 dragonheart Exp $

IUSE=""

DESCRIPTION="Passive per-connection tcp bandwidth monitor"
SRC_URI="http://www.rhythm.cx/~steve/devel/tcptrack/release/${PV}/source/${P}.tar.gz"
HOMEPAGE="http://www.rhythm.cx/~steve/devel/tcptrack/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

newdepend "virtual/libpcap
	   sys-libs/ncurses"

src_install() {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
