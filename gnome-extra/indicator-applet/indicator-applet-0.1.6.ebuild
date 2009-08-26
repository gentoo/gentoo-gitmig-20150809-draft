# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/indicator-applet/indicator-applet-0.1.6.ebuild,v 1.1 2009/08/26 06:13:22 ssuominen Exp $

EAPI=2
GCONF_DEBUG=no
inherit gnome2

DESCRIPTION="A small applet to display information from various applications consistently in the panel"
HOMEPAGE="https://launchpad.net/indicator-applet/"
SRC_URI="http://launchpad.net/${PN}/0.1/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3 LGPL-2.1 LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls"

RDEPEND=">=dev-libs/glib-2.18:2
	>=x11-libs/gtk+-2.12:2
	>=dev-libs/dbus-glib-0.76
	>=gnome-base/gnome-panel-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/gconf-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( dev-util/intltool )"

pkg_setup() {
	G2CONF="$(use_enable nls)
		--disable-dependency-tracking
		--disable-gobject-introspection"
	DOCS="AUTHORS"
}
