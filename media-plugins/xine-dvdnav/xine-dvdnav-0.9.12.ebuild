# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xine-dvdnav/xine-dvdnav-0.9.12.ebuild,v 1.3 2003/09/07 00:02:15 msterret Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="DVD Navigator plugin for Xine.  Also add CSS decription support."
HOMEPAGE="http://dvd.sourceforge.net/"
SRC_URI="mirror://sourceforge/dvd/${P}.tar.gz"

DEPEND=" >=media-libs/libdvdcss-0.0.3.3
	>=media-libs/libdvdread-0.9.2
	>=media-libs/libdvdnav-0.1.2
	>=media-libs/xine-lib-${PV}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"


src_compile () {

	econf || die
	emake || die
}

src_install() {

	einstall || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
