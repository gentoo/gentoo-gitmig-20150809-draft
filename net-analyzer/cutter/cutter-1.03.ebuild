# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cutter/cutter-1.03.ebuild,v 1.1 2005/05/15 00:53:33 vanquirius Exp $

DESCRIPTION="TCP/IP Connection cutting on Linux Firewalls and Routers"
SRC_URI="http://www.lowth.com/cutter/software/${P}.tgz"
HOMEPAGE="http://www.lowth.com/cutter"
LICENSE="GPL-2"
DEPEND=""
SLOT="0"
IUSE=""
KEYWORDS="~x86"

src_compile() {
	make || die
}

src_install () {
	# no make install yet, copy "cutter" to /usr/sbin
	dosbin cutter

	# Install documentation.
	dodoc COPYING README
}
