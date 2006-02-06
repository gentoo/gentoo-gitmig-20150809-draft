# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/wvdial/wvdial-1.54.0-r1.ebuild,v 1.6 2006/02/06 21:31:25 agriffis Exp $

inherit eutils

DESCRIPTION="Excellent program to automatically configure PPP sessions"
HOMEPAGE="http://open.nit.ca/wiki/?page=WvDial"
SRC_URI="http://open.nit.ca/download/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ~ppc sparc x86"
IUSE=""

DEPEND="virtual/libc
	net-dialup/ppp
	>=net-libs/wvstreams-4.0.2-r1"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-destdir.patch
}

src_compile() {
	emake CFLAGS="${CFLAGS} `pkg-config --cflags libwvstreams`" \
		LIBS="`pkg-config --libs libwvstreams`" || die "compile failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc CHANGES FAQ MENUS README TODO
}

pkg_postinst() {
	einfo
	einfo "Use wvdialconf to automagically generate a configuration file."
	einfo
	einfo "Users have to be member of the dialout AND the uucp group"
	einfo "to use wvdial!"
	einfo
}
