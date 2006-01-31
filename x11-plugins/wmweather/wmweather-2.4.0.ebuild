# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmweather/wmweather-2.4.0.ebuild,v 1.15 2006/01/31 21:08:32 nelchael Exp $

IUSE=""
DESCRIPTION="Dockable applet for WindowMaker that shows weather."
HOMEPAGE="http://www.godisch.de/debian/wmweather/"
SRC_URI="http://www.godisch.de/debian/wmweather/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc amd64 ~mips ppc ppc64"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXt
		x11-libs/libXext
		x11-libs/libXpm )
	virtual/x11 )
	net-misc/curl"
DEPEND="${RDEPEND}
	|| ( x11-proto/xextproto virtual/x11 )"

src_compile() {
	cd ${S}/src
	econf || die
	emake || die
}

src_install() {
	dodoc CHANGES README
	cd ${S}/src
	make DESTDIR=${D} install || die
}
