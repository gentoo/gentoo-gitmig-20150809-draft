# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libepc/libepc-0.4.1.ebuild,v 1.1 2011/10/09 22:41:00 pacho Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="Easy Publish and Consume library for network discovered services"
HOMEPAGE="http://live.gnome.org/libepc/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=net-dns/avahi-0.6[dbus,gtk3]
	>=dev-libs/glib-2.15.1
	>=net-libs/gnutls-1.4
	>=sys-libs/e2fsprogs-libs-1.36
	>=x11-libs/gtk+-3.0:3
	>=net-libs/libsoup-2.3:2.4"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.14
	>=dev-util/intltool-0.35.0
	doc? ( >=dev-util/gtk-doc-1.4 )"

DOCS="AUTHORS ChangeLog NEWS README"

# FIXME: 2 out of 16 tests fail, upstream bug #578792
RESTRICT="test"

src_test() {
	unset DBUS_SYSTEM_BUS_ADDRESS
	emake check || die "emake check failed"
}
