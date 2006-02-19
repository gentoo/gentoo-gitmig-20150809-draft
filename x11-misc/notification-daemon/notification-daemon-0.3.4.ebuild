# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/notification-daemon/notification-daemon-0.3.4.ebuild,v 1.1 2006/02/19 19:02:50 swegener Exp $

inherit gnome2

DESCRIPTION="Notifications daemon"
HOMEPAGE="http://www.galago-project.org/"
SRC_URI="http://www.galago-project.org/files/releases/source/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.4.0
	>=dev-libs/glib-2.4.0
	>=gnome-base/gconf-2.4.0
	>=x11-libs/libsexy-0.1.3
	>=sys-apps/dbus-0.36
	x11-libs/libwnck
	dev-libs/popt"
RDEPEND="${DEPEND}"

src_compile() {
	gnome2_src_compile --disable-schemas-install
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS
}
