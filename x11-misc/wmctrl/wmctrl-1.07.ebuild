# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmctrl/wmctrl-1.07.ebuild,v 1.6 2006/10/22 21:19:46 swegener Exp $

DESCRIPTION="command line tool to interact with an EWMH/NetWM compatible X Window Manager"
HOMEPAGE="http://sweb.cz/tripie/utils/wmctrl/"
SRC_URI="http://sweb.cz/tripie/utils/wmctrl/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE=""

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXt
		x11-libs/libXmu )
	virtual/x11 )
	>=dev-libs/glib-2"
DEPEND="${RDEPEND}
	|| ( x11-proto/xproto virtual/x11 )"

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
