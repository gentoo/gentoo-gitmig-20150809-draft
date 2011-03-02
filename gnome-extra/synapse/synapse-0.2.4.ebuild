# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/synapse/synapse-0.2.4.ebuild,v 1.2 2011/03/02 08:46:14 eva Exp $

EAPI=4
inherit gnome2-utils

DESCRIPTION="A program launcher in the style of GNOME Do"
HOMEPAGE="http://launchpad.net/synapse-project"
SRC_URI="http://launchpad.net/synapse-project/0.2/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/vala:0.12
	x11-libs/gtkhotkey
	dev-libs/libgee
	dev-libs/json-glib
	x11-libs/gtk+:2
	dev-libs/glib:2
	x11-libs/libnotify
	dev-libs/libunique:1
	gnome-extra/zeitgeist[fts]
	dev-libs/libzeitgeist
	dev-libs/dbus-glib
	sys-apps/dbus
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtkhotkey
	x11-libs/pango"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_preinst() {
	gnome2_icon_savelist
}

src_prepare() {
	sed -i -e 's/GNOME/GNOME;GTK/' data/synapse.desktop.in
}

src_configure() {
	econf VALAC="$(type -P valac-0.12)"
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
