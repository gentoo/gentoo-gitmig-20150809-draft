# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ldcc/ldcc-2.0.7.ebuild,v 1.1 2003/04/24 14:41:58 vapier Exp $

DESCRIPTION="linux console, text-based client for DIRECT CONNECT"
HOMEPAGE="http://www.softservice.com.pl/ldcc/"
SRC_URI="http://main.loop.com.pl/~softservice/ldcc/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="net-p2p/dctc
	dev-libs/tvision"

src_compile() {
	econf \
		--with-tv-include=/usr/include/rhtvision \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS README
}
