# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author David Rufino <daverufino@btinternet.com>
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpg321/mpg321-0.2.2.ebuild,v 1.1 2001/11/14 15:57:12 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Free MP3 player, drop-in replacement for mpg123"
SRC_URI="http://prdownloads.sourceforge.net/${PN}/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/${P}/"

DEPEND="virtual/glibc
		>=media-sound/mad-0.14.2b
		>=media-libs/libao-0.8.0"

src_compile() {
	./configure --build=${CHOST} \
		--prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	# don't create mpg123 symlink -- conflicts with media-sound/mpg123
	rm -f ${D}/usr/bin/mpg123
}
