# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libipoddevice/libipoddevice-0.5.3.ebuild,v 1.5 2007/08/24 03:22:28 metalgod Exp $

inherit eutils

DESCRIPTION="device-specific layer for the Apple iPod"
HOMEPAGE="http://banshee-project.org/Libipoddevice"
SRC_URI="http://banshee-project.org/files/libipoddevice/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=dev-libs/dbus-glib-0.71
	>=sys-apps/hal-0.5.2
	sys-apps/pmount
	virtual/eject"
DEPEND="${RDEPEND}
	>=dev-libs/glib-2.0
	>=gnome-base/libgtop-2.12
	>=sys-apps/sg3_utils-1.20"

pkg_setup() {
	if [ ! -z $(best_version =sys-apps/dbus-0.62*) ]; then
		if ! built_with_use "=sys-apps/dbus-0.62*" gtk; then
			die "need sys-libs/dbus built with gtk USE flag"
		fi
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# use correct libdir in pkgconfig file
	sed -i \
		-e 's:^libdir=.*:libdir=@libdir@:' \
		ipoddevice.pc.in \
		|| die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog NEWS README
}
