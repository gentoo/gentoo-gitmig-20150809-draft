# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/camserv/camserv-0.5.1-r2.ebuild,v 1.5 2004/06/11 13:53:20 vapier Exp $

inherit eutils

DESCRIPTION="A streaming video server"
HOMEPAGE="http://cserv.sourceforge.net/"
SRC_URI="mirror://sourceforge/cserv/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=media-libs/jpeg-6b-r2
	>=media-libs/imlib-1.9.13-r2
	>=sys-devel/autoconf-2.58"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-0.5-errno.patch
	cd libltdl
	WANT_AUTOCONF=2.5 autoconf || die "autoconf failed"
}

src_install() {
	make install DESTDIR=${D} || die

	dodoc AUTHORS BUGS ChangeLog NEWS README TODO javascript.txt

	exeinto /etc/init.d
	newexe ${FILESDIR}/camserv.init camserv
}
