# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmvolman/wmvolman-0.9.ebuild,v 1.1 2008/01/17 08:01:20 drac Exp $

DESCRIPTION="a dockapp that displays and (un)mounts hotplug devices and removable media."
HOMEPAGE="http://people.altlinux.ru/~raorn/wmvolman.html"
SRC_URI="http://people.altlinux.ru/~raorn/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=x11-libs/libdockapp-0.6
	x11-libs/libX11
	dev-libs/dbus-glib
	sys-apps/pmount
	sys-apps/hal"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS NEWS README
}
