# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmctrl/wmctrl-1.07.ebuild,v 1.8 2012/05/05 04:53:43 jdhore Exp $

DESCRIPTION="command line tool to interact with an EWMH/NetWM compatible X Window Manager"
HOMEPAGE="http://sweb.cz/tripie/utils/wmctrl/"
SRC_URI="http://sweb.cz/tripie/utils/wmctrl/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	x11-libs/libX11
	x11-libs/libXt
	x11-libs/libXmu"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	x11-proto/xproto"

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
