# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libosinfo/libosinfo-0.1.1.ebuild,v 1.1 2012/04/26 21:13:06 nirbheek Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="GObject library for managing information about real and virtual OSes"
HOMEPAGE="https://fedorahosted.org/libosinfo/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
SRC_URI="https://fedorahosted.org/releases/l/i/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE="doc +introspection +vala test"

REQUIRED_USE="vala? ( introspection )"

RDEPEND="
	dev-libs/glib:2
	net-libs/libsoup:2.4
	net-libs/libsoup-gnome:2.4
	>=dev-libs/libxml2-2.6.0:2
	introspection? ( >=dev-libs/gobject-introspection-0.9.0 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.10 )
	test? ( dev-libs/check )
	vala? ( dev-lang/vala:0.14 )"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	# --enable-udev only installs udev rules
	G2CONF="--disable-coverage
		--disable-static
		--enable-udev
		--with-udev-rulesdir=/lib/udev/rules.d
		VAPIGEN=$(type -P vapigen-0.14)
		$(use_enable introspection)
		$(use_enable test tests)
		$(use_enable vala)"
}
