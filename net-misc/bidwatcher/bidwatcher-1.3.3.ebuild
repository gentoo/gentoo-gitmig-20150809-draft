# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bidwatcher/bidwatcher-1.3.3.ebuild,v 1.4 2002/08/14 12:08:07 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="eBay auction watcher and snipe agent"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://bidwatcher.sourceforge.net/"

DEPEND="virtual/glibc
	=x11-libs/gtk+-1.2*
	=dev-libs/glib-1.2*"
RDEPEND=${DEPEND}

KEYWORDS="x86 sparc sparc64"
LICENSE="GPL-2"
SLOT="0"

src_compile() {
	./configure \
		--build=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info || die "./configure failed"

	emake || die
}

src_install () {
    make DESTDIR=${D} install || die
    dodoc quick_start.html README COPYING NEWS  AUTHORS ChangeLog TODO
}
