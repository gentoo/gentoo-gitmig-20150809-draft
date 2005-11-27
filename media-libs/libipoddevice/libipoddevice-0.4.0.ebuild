# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libipoddevice/libipoddevice-0.4.0.ebuild,v 1.1 2005/11/27 19:51:43 metalgod Exp $

inherit eutils

DESCRIPTION="libipoddevice is a device-specific layer for the Apple iPod"
HOMEPAGE="http://banshee-project.org/Libipoddevice"
SRC_URI="http://banshee-project.org/files/libipoddevice/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=sys-apps/dbus-0.30
	>=sys-apps/hal-0.5.2
	sys-apps/pmount
	virtual/eject"
DEPEND="${RDEPEND}
	>=dev-libs/glib-2.0
	>=gnome-base/libgtop-2.12"

pkg_setup() {
	if ! built_with_use sys-apps/dbus gtk; then
		die "need sys-libs/dbus built with gtk USE flag"
	fi
}
src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}
src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog NEWS README
}
