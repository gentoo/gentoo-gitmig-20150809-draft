# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/shout/shout-0.8.0-r1.ebuild,v 1.1 2002/07/24 00:19:59 raker Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Shout is a prgram for creatinga mp3 stream for use with icecast or shoutcast."
SRC_URI="http://www.icecast.org/releases/${P}.tar.gz"
HOMEPAGE="http://www.icecast.org"
KEYWORDS="x86"
LICENSE="GPL"
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
