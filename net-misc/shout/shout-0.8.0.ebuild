# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/shout/shout-0.8.0.ebuild,v 1.14 2004/08/08 14:09:29 kloeri Exp $

IUSE=""
DESCRIPTION="Shout is a program for creating a mp3 stream for use with icecast or shoutcast"
SRC_URI="http://www.icecast.org/releases/${P}.tar.gz"
HOMEPAGE="http://www.icecast.org"
KEYWORDS="x86 sparc "
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/libc"

src_compile() {
	rm -f sock.o
	./configure --prefix=/usr		\
		--infodir=/usr/share/info   \
				--mandir=/usr/share/man     \
				--host=${CHOST} || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc BUGS CREDITS README.shout TODO
}
