# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmauda/wmauda-0.7.ebuild,v 1.1 2007/11/10 17:08:50 joker Exp $

inherit eutils

IUSE=""

DESCRIPTION="Dockable applet for WindowMaker that controls Audacious."
SRC_URI="http://www.netswarm.net/misc/${P}.tar.gz"
HOMEPAGE="http://www.netswarm.net/"

DEPEND="=x11-libs/gtk+-2*
	dev-libs/dbus-glib
	>=media-sound/audacious-1.4"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

pkg_setup() {
	if ! built_with_use media-sound/audacious dbus ; then
		eerror
		eerror "Audacious must be built with dbus support."
		eerror
		die
	fi
}

src_compile() {
	emake || die
}

src_install () {
	make DESTDIR="${D}" PREFIX="/usr" install || die "make install failed"
	dodoc README AUTHORS
}
