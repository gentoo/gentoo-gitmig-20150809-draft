# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libsmtp/libsmtp-0.8.ebuild,v 1.1 2004/12/22 14:23:51 ka0ttic Exp $

inherit eutils

DESCRIPTION="A small C library that allows direct SMTP connections conforming to RFC 822"
HOMEPAGE="http://libsmtp.berlios.de/"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND="virtual/libc
	dev-libs/glib"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_install() {
	dolib.a smtp/libsmtp.a mime/libsmtp_mime.a || die "dolib.a failed"
	dodoc AUTHORS CHANGES INSTALL README doc/API doc/BUGS doc/MIME doc/TODO \
		|| die "dodoc failed"

	if use doc ; then
		cd ${S}/examples
		rm -fr CVS
		make clean
		docinto examples
		dodoc *
	fi
}
