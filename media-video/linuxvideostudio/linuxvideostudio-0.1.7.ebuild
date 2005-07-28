# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/linuxvideostudio/linuxvideostudio-0.1.7.ebuild,v 1.5 2005/07/28 10:38:49 dholm Exp $

DESCRIPTION="small-'n-simple GUI for the MJPEG-tools"
HOMEPAGE="http://ronald.bitfreak.net/"
SRC_URI="http://ronald.bitfreak.net/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~ppc ~x86"

IUSE="lirc"

DEPEND=">=media-video/mjpegtools-1.6.0-r7
		=x11-libs/gtk+-1.2*
		media-libs/gdk-pixbuf
		media-libs/libpng
		media-libs/jpeg
		lirc? ( app-misc/lirc )"

src_compile() {
	local myconf
	# setting the --with-lircd option somehow makes the test fail
	if ! use lirc; then
		myconf="--without-lircd"
	fi
	econf $myconf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog README TODO README.stv ChangeLog.stv INSTALL.stv INSTALL
}
