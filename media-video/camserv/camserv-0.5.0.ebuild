# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/camserv/camserv-0.5.0.ebuild,v 1.11 2004/06/11 13:53:20 vapier Exp $

inherit eutils

DESCRIPTION="A streaming video server"
HOMEPAGE="http://cserv.sourceforge.net/"
SRC_URI="http://cserv.sourceforge.net/current/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=media-libs/jpeg-6b-r2
	>=media-libs/imlib-1.9.13-r2"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-0.5-errno.patch
}

src_install() {
	einstall datadir=${D}/usr/share/${PN} || die

	dodoc AUTHORS BUGS ChangeLog NEWS README TODO javascript.txt
	dohtml defpage.html
}
