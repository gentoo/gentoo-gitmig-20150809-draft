# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/wvdial/wvdial-1.54.0.ebuild,v 1.3 2004/03/24 17:17:24 mholzer Exp $

inherit flag-o-matic

DESCRIPTION="Excellent program to automatically configure PPP sessions"
HOMEPAGE="http://open.nit.ca/wiki/?page=WvDial"
SRC_URI="http://open.nit.ca/download/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~alpha ~amd64 ~hppa"

DEPEND="virtual/glibc
	net-dialup/ppp
	>=net-libs/wvstreams-3.74"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-makefile.patch
}

src_compile() {
	[ "${ARCH}" = "alpha" -o "${ARCH}" = "hppa" ] && append-libs -fPIC
	emake || die "compile failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc COPYING.LIB CHANGES FAQ MENUS README TODO
}

pkg_postinst() {
	einfo
	einfo "Use wvdialconf to automagically generate a configuration file."
	einfo
	einfo "Users have to be member of the dialout AND the uucp group"
	einfo "to use wvdial!"
	einfo
}
