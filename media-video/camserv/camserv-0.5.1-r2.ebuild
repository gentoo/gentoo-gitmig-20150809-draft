# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/camserv/camserv-0.5.1-r2.ebuild,v 1.8 2005/09/02 21:37:45 flameeyes Exp $

inherit eutils autotools

DESCRIPTION="A streaming video server"
HOMEPAGE="http://cserv.sourceforge.net/"
SRC_URI="mirror://sourceforge/cserv/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

RDEPEND=">=media-libs/jpeg-6b-r2
	>=media-libs/imlib-1.9.13-r2"

DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.58"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-0.5-errno.patch
	cd libltdl
	eautoconf
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO javascript.txt

	newinitd ${FILESDIR}/camserv.init camserv
}
