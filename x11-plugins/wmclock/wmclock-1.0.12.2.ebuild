# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmclock/wmclock-1.0.12.2.ebuild,v 1.12 2008/06/29 13:54:02 drac Exp $

DESCRIPTION="a dockapp that displays time and date (same style as NEXTSTEP(tm) operating systems)"
SRC_URI="http://www.jmknoble.net/WindowMaker/wmclock/${P}.tar.gz"
HOMEPAGE="http://www.jmknoble.net/WindowMaker/wmclock/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto
	x11-misc/gccmakedep
	x11-misc/imake"

src_install() {
	dobin wmclock || die "dobin failed."
	newman wmclock.man wmclock.1
	dodoc ChangeLog README
}
