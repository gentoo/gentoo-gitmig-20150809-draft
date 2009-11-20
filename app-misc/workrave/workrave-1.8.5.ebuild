# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/workrave/workrave-1.8.5.ebuild,v 1.7 2009/11/20 17:04:13 ssuominen Exp $

inherit eutils gnome2

DESCRIPTION="Helpful utility to attack Repetitive Strain Injury (RSI)"
HOMEPAGE="http://workrave.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="dbus distribution gnome nls xml"

RDEPEND=">=dev-libs/glib-2
	>=gnome-base/gconf-2
	>=x11-libs/gtk+-2
	>=dev-cpp/gtkmm-2.4
	>=dev-cpp/glibmm-2.4
	>=dev-libs/libsigc++-2
	gnome? (
		>=gnome-base/libgnomeui-2
		>=dev-cpp/libgnomeuimm-2.6
		>=gnome-base/gnome-panel-2.0.10
		>=gnome-base/libbonobo-2
		>=gnome-base/orbit-2.8.3 )
	distribution? ( >=net-libs/gnet-2 )
	dbus? (
		>=sys-apps/dbus-0.92
		dev-libs/dbus-glib )
	xml? ( dev-libs/gdome2 )
	x11-libs/libX11
	x11-libs/libXtst
	x11-libs/libXt
	x11-libs/libXmu"

DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/inputproto
	x11-proto/recordproto

	nls? ( sys-devel/gettext )
	>=dev-util/pkgconfig-0.9"

MAKEOPTS="${MAKEOPTS} -j1"
DOCS="AUTHORS NEWS README TODO"

pkg_setup() {
	G2CONF="--enable-gconf
		$(use_enable dbus)
		$(use_enable distribution)
		$(use_enable gnome)
		$(use_enable gnome gnomemm)
		--disable-kde
		$(use_enable nls)
		$(use_enable xml)
		--without-arts"
}

src_unpack() {
	gnome2_src_unpack

	# Removes a few broken macros. See bug #86939.
	epatch "${FILESDIR}/${PN}-1.8.4-nls_macros.patch"

	# Fix compilation issues, bug #220657
	epatch "${FILESDIR}/${P}-gcc43.patch"
	epatch "${FILESDIR}/${P}-libsigc++-2.2.2.patch"

	# Fix intltool tests
	echo "common/src/glibnls.c" >> po/POTFILES.in
	echo "frontend/gtkmm/src/gnome_applet/GNOME_WorkraveApplet.xml" >> po/POTFILES.in
	echo "frontend/gtkmm/src/gnome_applet/Workrave-Applet.server.in" >>	po/POTFILES.in
	echo "frontend/gtkmm/src/gnome_applet/WorkraveApplet.c" >> po/POTFILES.in
}
