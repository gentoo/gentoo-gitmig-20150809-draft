# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/shout/shout-0.8.0-r2.ebuild,v 1.2 2004/11/05 23:52:37 chriswhite Exp $

IUSE=""

inherit eutils

DESCRIPTION="Shout is a program for creating mp3 stream for use with icecast or shoutcast"
SRC_URI="http://icecast.org/releases/${P}.tar.gz"
HOMEPAGE="http://www.icecast.org"
KEYWORDS="x86 sparc ~ppc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/variables.diff

	rm -f sock.o
}

src_compile() {
	./configure --prefix=/usr \
		--host=${CHOST} \
		--sysconfdir=/etc/shout \
		--localstatedir=/var \
		|| die "configure failed"

	emake || die "emake failed"
}


src_install () {
	make DESTDIR=${D} install || die
	keepdir /var/log/shout
	fowners root:audio /var/log/shout
	fperms 775 /var/log/shout
	fperms 755 /etc/shout
	fperms 644 /etc/shout/shout.conf.dist
	dodoc BUGS CREDITS README.shout TODO
}
