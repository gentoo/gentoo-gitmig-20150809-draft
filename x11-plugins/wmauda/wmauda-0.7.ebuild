# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmauda/wmauda-0.7.ebuild,v 1.6 2009/08/16 09:15:27 betelgeuse Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Dockable applet for WindowMaker that controls Audacious."
HOMEPAGE="http://www.netswarm.net"
SRC_URI="http://www.netswarm.net/misc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND="dev-libs/dbus-glib
	x11-libs/libX11
	>=x11-libs/gtk+-2
	>=media-sound/audacious-1.5"
DEPEND="${RDEPEND}
	x11-proto/xproto
	dev-util/pkgconfig"

src_compile() {
	tc-export CC
	emake || die "emake failed."
}

src_install () {
	emake DESTDIR="${D}" PREFIX="/usr" install || die "emake install failed."
	dodoc AUTHORS README
}
