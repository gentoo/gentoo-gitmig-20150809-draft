# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cutter/cutter-1.02.ebuild,v 1.1 2003/07/02 07:30:48 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="TCP/IP Connection cutting on Linux Firewalls and Routers"
SRC_URI="http://www.lowth.com/cutter/${P}.tgz"
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
