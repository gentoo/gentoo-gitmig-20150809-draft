# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/squelch/squelch-1.0.1.ebuild,v 1.1 2002/12/19 19:08:28 danarmak Exp $
inherit kde-functions
S=${WORKDIR}/${P}
DESCRIPTION="qt-based Ogg Vorbis player"
SRC_URI="http://rikkus.info/arch/${P}.tar.gz"
HOMEPAGE="http://rikkus.info/squelch.html"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~x86"

DEPEND="media-libs/libvorbis
	media-libs/libao"

need-qt 3

src_compile() {
	./configure --prefix=/usr
	make || die "Make failed"
}

src_install() {
	dobin src/squelch
	dodoc AUTHORS COPYING INSTALL README THANKS
}

