# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/gnome-bluetooth/gnome-bluetooth-2.28.1.ebuild,v 1.2 2009/09/30 10:13:19 nirbheek Exp $

EAPI="2"

inherit autotools eutils gnome2

DESCRIPTION="Fork of bluez-gnome focused on integration with GNOME"
HOMEPAGE="http://live.gnome.org/GnomeBluetooth"
LICENSE="GPL-2 LGPL-2.1"
SLOT="2"
IUSE="doc"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"

COMMON_DEPEND=">=dev-libs/glib-2.16
	>=x11-libs/gtk+-2.15
	>=x11-libs/libnotify-0.4.3
	>=gnome-base/gconf-2.6
	>=dev-libs/dbus-glib-0.74
	dev-libs/libunique"
DEPEND="${COMMON_DEPEND}
	!!net-wireless/bluez-gnome
	app-text/gnome-doc-utils
	app-text/scrollkeeper
	dev-libs/libxml2
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext
	x11-proto/xproto
	doc? ( >=dev-util/gtk-doc-1.9 )"
RDEPEND="${COMMON_DEPEND}
	>=net-wireless/bluez-4.34
	>=app-mobilephone/obex-data-server-0.4"

DOCS="AUTHORS README NEWS ChangeLog"
G2CONF="${G2CONF}
--disable-desktop-update
--disable-icon-update
--disable-introspection"

src_prepare() {
	# Fix intltoolize broken file, see upstream #577133 and #579464
	sed "s:'\^\$\$lang\$\$':\^\$\$lang\$\$:g" -i po/Makefile.in.in \
		|| die "sed failed"
	
	# Patch is from upstream 2.28 branch, bug 287043
	epatch "${FILESDIR}/${P}-fix-smp-build.patch"

	eautoreconf
}
