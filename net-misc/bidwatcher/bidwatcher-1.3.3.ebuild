# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bidwatcher/bidwatcher-1.3.3.ebuild,v 1.8 2003/02/13 14:45:40 vapier Exp $

DESCRIPTION="eBay auction watcher and snipe agent"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://bidwatcher.sourceforge.net/"

KEYWORDS="x86 sparc"
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
