# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bidwatcher/bidwatcher-1.3.7.ebuild,v 1.2 2003/01/02 15:43:15 mholzer Exp $

IUSE=""

DESCRIPTION="eBay auction watcher and sniper agent"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://bidwatcher.sourceforge.net/"

KEYWORDS="x86 ~sparc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc
	=x11-libs/gtk+-1.2*
	=dev-libs/glib-1.2*"

src_compile() {
	econf
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc quick_start.html README COPYING NEWS AUTHORS ChangeLog TODO
}
