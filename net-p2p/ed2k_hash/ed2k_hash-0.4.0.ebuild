# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ed2k_hash/ed2k_hash-0.4.0.ebuild,v 1.3 2004/06/02 13:51:46 squinky86 Exp $

DESCRIPTION="Tool for generating eDonkey2000 links"
HOMEPAGE="http://ed2k-tools.sourceforge.net/${PN}.shtml"
RESTRICT="nomirror"
SRC_URI="mirror://sourceforge/ed2k-tools/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
DEPEND="virtual/glibc"

src_install() {
	make install DESTDIR=${D} || die

	dodoc AUTHORS COPYING INSTALL README TODO
}
