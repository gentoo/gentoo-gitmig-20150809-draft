# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/bmpx/bmpx-0.40.1.ebuild,v 1.1 2007/08/11 21:24:30 drac Exp $

inherit fdo-mime gnome2-utils versionator

MY_PR="$(get_version_component_range 1-2 ${PV})"

DESCRIPTION="Next generation Beep Media Player"
HOMEPAGE="http://www.beep-media-player.org"
SRC_URI="http://files.beep-media-player.org/releases/${MY_PR}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug hal modplug sid startup-notification"

RDEPEND=">=net-libs/libsoup-2.2.100
	>=dev-db/sqlite-3.3.11
	>=dev-libs/glib-2.10
	>=dev-cpp/glibmm-2.12
	>=dev-libs/libsigc++-2
	>=x11-libs/gtk+-2.10
	>=gnome-base/librsvg-2.14
	>=dev-cpp/gtkmm-2.10
	>=dev-cpp/libglademm-2.6
	>=dev-cpp/cairomm-0.6
	>=dev-cpp/libsexymm-0.1.9
	>=dev-libs/libxml2-2.6.1
	>=media-libs/gst-plugins-base-0.10.11
	>=dev-libs/dbus-glib-0.61
	>=media-libs/taglib-1.4
	media-sound/cdparanoia
	app-arch/zip
	media-libs/alsa-lib
	>=dev-libs/boost-1.33.1
	>=media-libs/libofa-0.9.3
	hal? ( >=sys-apps/hal-0.5.7.1 )
	sid? ( =media-libs/libsidplay-1* )
	modplug? ( >=media-libs/libmodplug-0.8 )
	startup-notification? ( x11-libs/startup-notification )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	dev-util/intltool
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt"

src_compile() {
	econf --with-tr1 \
		$(use_enable modplug) \
		$(use_enable hal) \
		$(use_enable sid) \
		$(use_enable startup-notification sn) \
		$(use_enable debug)

	emake -j1 || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS README
}

pkg_postinst() {
	einfo
	elog "You have to install gst-plugins you want yourself,"
	elog "they are optional runtime depends."
	einfo
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
