# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/synapse/synapse-0.2.8.2.ebuild,v 1.1 2012/01/29 16:45:56 jlec Exp $

EAPI=4

inherit gnome2-utils

DESCRIPTION="A program launcher in the style of GNOME Do"
HOMEPAGE="http://launchpad.net/synapse-project/"
SRC_URI="http://launchpad.net/synapse-project/0.2/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ayatana plugins +zeitgeist"

RDEPEND="
	dev-lang/vala:0.12
	dev-libs/dbus-glib
	dev-libs/libgee:0
	dev-libs/libzeitgeist
	dev-libs/glib:2
	dev-libs/json-glib
	dev-libs/libunique:1
	sys-apps/dbus
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtkhotkey
	x11-libs/gtk+:2
	x11-libs/libnotify
	x11-libs/pango
	x11-themes/gnome-icon-theme
	ayatana? ( dev-libs/libappindicator )
	plugins? ( net-libs/rest )
	zeitgeist? (
		dev-libs/libzeitgeist
		gnome-extra/zeitgeist[fts]
		)"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

pkg_preinst() {
	gnome2_icon_savelist
}

src_prepare() {
	sed -i -e 's/GNOME/GNOME;GTK/' data/synapse.desktop.in
}

src_configure() {
	VALAC="$(type -P valac-0.12)" \
		econf \
			$(use_enable ayatana indicator yes) \
			$(use_enable plugins librest yes) \
			$(use_enable zeitgeist)
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
