# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/shout/shout-0.8.0-r1.ebuild,v 1.9 2003/09/05 22:01:49 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Shout is a program for creating mp3 stream for use with icecast or shoutcast"
SRC_URI="http://www.icecast.org/releases/${P}.tar.gz"
HOMEPAGE="http://www.icecast.org"
KEYWORDS="x86 sparc ~ppc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/variables.diff

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
	dodoc BUGS CREDITS README.shout TODO
}
