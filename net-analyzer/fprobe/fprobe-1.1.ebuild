# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fprobe/fprobe-1.1.ebuild,v 1.1 2005/02/03 11:48:55 ka0ttic Exp $

DESCRIPTION="A libpcap-based tool to collect network traffic data and emit it as NetFlow flows"
HOMEPAGE="http://fprobe.sourceforge.net"
LICENSE="GPL-2"

SRC_URI="mirror://sourceforge/fprobe/${P}.tar.bz2"
SLOT="0"
KEYWORDS="x86 ~ppc"

IUSE="debug messages"

DEPEND="virtual/libpcap"

src_compile() {
	local myconf
	myconf="`use_enable debug`
		`use_enable messages`"

	econf ${myconf} || die "configure failed"

	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"

	dodoc AUTHORS COPYING INSTALL NEWS README TODO
	docinto contrib ; dodoc contrib/tg.sh
}
