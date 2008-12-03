# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/shout/shout-0.8.0-r2.ebuild,v 1.6 2008/12/03 06:32:55 ssuominen Exp $

inherit eutils

DESCRIPTION="Shout is a program for creating mp3 stream for use with icecast or shoutcast"
HOMEPAGE="http://www.icecast.org"
SRC_URI="http://icecast.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~ppc sparc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/variables.diff
	rm -f sock.o
}

src_compile() {
	./configure --prefix=/usr \
		--host=${CHOST} \
		--sysconfdir=/etc/shout \
		--localstatedir=/var \
		|| die "econf failed."

	emake || die "emake failed."
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed."
	keepdir /var/log/shout
	fowners root:audio /var/log/shout
	fperms 775 /var/log/shout
	fperms 755 /etc/shout
	fperms 644 /etc/shout/shout.conf.dist
	dodoc BUGS CREDITS README.shout TODO
}
