# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcptrack/tcptrack-1.1.5.ebuild,v 1.4 2006/06/01 20:37:20 exg Exp $

inherit eutils

DESCRIPTION="Passive per-connection tcp bandwidth monitor"
HOMEPAGE="http://www.rhythm.cx/~steve/devel/tcptrack/"
SRC_URI="http://www.rhythm.cx/~steve/devel/tcptrack/release/${PV}/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

DEPEND="net-libs/libpcap
	sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ${FILESDIR}/${P}-gcc41.patch
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
