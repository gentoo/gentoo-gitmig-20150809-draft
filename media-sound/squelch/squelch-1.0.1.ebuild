# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/squelch/squelch-1.0.1.ebuild,v 1.5 2004/01/04 02:23:25 caleb Exp $

DESCRIPTION="qt-based Ogg Vorbis player"
HOMEPAGE="http://rikkus.info/squelch.html"
SRC_URI="http://rikkus.info/arch/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86"

DEPEND="media-libs/libvorbis
	media-libs/libao
	>=x11-libs/qt-3"

src_compile() {
	./configure --prefix=/usr
	make || die "Make failed"
}

src_install() {
	dobin src/squelch
	dodoc AUTHORS COPYING INSTALL README THANKS
}
