# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/temperature-app/temperature-app-1.4.ebuild,v 1.7 2007/07/22 03:42:37 dberkholz Exp $

IUSE=""

MY_PN=${PN/-/.}
MY_PN=${MY_PN/t/T}
S="${WORKDIR}/${MY_PN}-${PV}"

DESCRIPTION="Temperature.app is a Window Maker dockapp to display the local temperature in either celsius or fahrenheit."
SRC_URI="http://www.fukt.bth.se/~per/temperature/${MY_PN}-${PV}.tar.gz"
HOMEPAGE="http://www.fukt.bth.se/~per/temperature/"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	net-misc/wget"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {
	emake || die "make failed"
}

src_install () {
	dobin Temperature.app
	dodoc README ChangeLog
}
