# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/bmpx/bmpx-0.40.14.ebuild,v 1.2 2008/05/13 06:16:42 drac Exp $

EAPI=1

inherit eutils fdo-mime gnome2-utils versionator

MY_PR=$(get_version_component_range 1-2)

DESCRIPTION="Next generation Beep Media Player"
HOMEPAGE="http://bmpx.backtrace.info/site/BMPx_Homepage"
SRC_URI="http://files.backtrace.info/releases/${MY_PR}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug doc hal modplug networkmanager sid startup-notification"

RDEPEND=">=net-libs/libsoup-2.2.100:2.2
	>=dev-db/sqlite-3.4
	>=dev-libs/glib-2.10
	>=dev-cpp/glibmm-2.12
	>=dev-libs/libsigc++-2
	>=x11-libs/gtk+-2.12
	>=gnome-base/librsvg-2.14
	>=dev-cpp/gtkmm-2.12
	>=dev-cpp/libglademm-2.6
	>=dev-cpp/cairomm-0.6
	>=dev-cpp/libsexymm-0.1.9
	>=dev-libs/libxml2-2.6.1
	>=media-libs/gst-plugins-base-0.10.14
	>=dev-libs/dbus-glib-0.61
	>=media-libs/taglib-1.4
	dev-libs/libcdio
	app-arch/zip
	media-libs/alsa-lib
	>=dev-libs/boost-1.33.1
	>=media-libs/libofa-0.9.3
	hal? ( >=sys-apps/hal-0.5.7.1 )
	sid? ( =media-libs/libsidplay-1* )
	modplug? ( >=media-libs/libmodplug-0.8 )
	startup-notification? ( x11-libs/startup-notification )
	networkmanager? ( >=net-misc/networkmanager-0.6 )
	media-plugins/gst-plugins-meta"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	dev-util/intltool
	>=x11-proto/xproto-7.0.10
	doc? ( app-text/docbook-xsl-stylesheets	dev-libs/libxslt )"

src_compile() {
	econf --with-tr1 --enable-ld-workaround \
		$(use_enable modplug) \
		$(use_enable hal) \
		$(use_enable sid) \
		$(use_enable startup-notification sn) \
		$(use_enable debug) \
		$(use_with networkmanager nm) \
		$(use_enable doc)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
