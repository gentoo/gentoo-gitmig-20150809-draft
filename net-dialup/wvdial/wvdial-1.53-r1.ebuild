# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/wvdial/wvdial-1.53-r1.ebuild,v 1.13 2004/12/08 18:01:44 mrness Exp $

inherit eutils

DESCRIPTION="Excellent program which automatically configures your PPP session"
SRC_URI="http://open.nit.ca/download/${P}.tar.gz"
HOMEPAGE="http://open.nit.ca/"

DEPEND="virtual/libc
	>=sys-apps/sed-4
	net-libs/wvstreams"

RDEPEND="${DEPEND}
	net-dialup/ppp"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 sparc amd64 hppa alpha"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-crypt.patch
}

src_compile() {
	sed -i "s:PREFIX=/usr/local:PREFIX=/usr:" Makefile || \
		die "sed Makefile failed"
}

src_install() {
	sed -i "s:PPPDIR=/etc/ppp/peers:PPPDIR=${D}/etc/ppp/peers:" Makefile || \
		die "sed Makefile failed"

	make \
		PREFIX=${D}/usr \
		install || die "make install failed"

	dodoc ANNOUNCE CHANGES COPYING.LIB README
	dodoc debian/copyright debian/changelog
}

pkg_postinst() {
	einfo
	einfo "Use wvdialconf to automagically generate a configuration-file."
	einfo
	einfo "Users have to be member of the dialout AND the uucp group"
	einfo "to use wvdial!"
	einfo
}
