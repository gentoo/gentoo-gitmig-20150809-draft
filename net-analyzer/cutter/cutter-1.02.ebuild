# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cutter/cutter-1.02.ebuild,v 1.6 2006/02/25 23:41:20 vanquirius Exp $

DESCRIPTION="TCP/IP Connection cutting on Linux Firewalls and Routers"
SRC_URI="http://www.lowth.com/cutter/${P}.tgz"
HOMEPAGE="http://www.lowth.com/cutter"
LICENSE="GPL-2"
DEPEND=""
SLOT="0"
IUSE=""
KEYWORDS="x86"

src_compile() {
	make || die
}

src_install () {
	# no make install yet, copy "cutter" to /usr/sbin
	dosbin cutter

	# Install documentation.
	dodoc README
}
