# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/workrave/workrave-1.9.0.ebuild,v 1.5 2009/11/20 17:04:13 ssuominen Exp $

inherit autotools eutils gnome2

DESCRIPTION="Helpful utility to attack Repetitive Strain Injury (RSI)"
HOMEPAGE="http://workrave.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dbus distribution gnome nls xml"

RDEPEND=">=dev-libs/glib-2
	>=gnome-base/gconf-2
	>=x11-libs/gtk+-2.6
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
		>=sys-apps/dbus-1.0
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
	dev-python/cheetah
	nls? ( sys-devel/gettext )
	>=dev-util/pkgconfig-0.9"
# Currently freezes workrave
#	gstreamer? (
#		>=media-libs/gstreamer-0.10 )

DOCS="AUTHORS NEWS README TODO"

pkg_setup() {
	G2CONF="--enable-gconf
		--disable-gstreamer
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

	# Fix intltool tests
	echo "frontend/gtkmm/src/gnome_applet/Workrave-Applet.server.in" >> po/POTFILES.skip
	echo "intl/plural.c" >> po/POTFILES.skip

	# Copy files missing from tarball
	cp "${FILESDIR}/${P}-gui.xml" "${S}/frontend/gtkmm/src/workrave-gui.xml"
	cp "${FILESDIR}/${P}-dbus-glib.xml" "${S}/common/bin/DBus-glib.xml"
	cp "${FILESDIR}/${P}-service.in" "${S}/frontend/gtkmm/src/org.workrave.Workrave.service.in"

	# Fix compilation with gcc-4
	epatch "${FILESDIR}/${P}-gcc43.patch"
	epatch "${FILESDIR}/${P}-gcc44.patch"

	# Fix compilation with USE="-distribution"
	epatch "${FILESDIR}/${P}-compilation-fixes.patch"

	# Fix parallel make issues ?
	epatch "${FILESDIR}/${P}-parallel-make.patch"

	# Fix compilation with no sound framework enabled, bug #249683
	epatch "${FILESDIR}/${P}-nosoundplayer.patch"

	eautoreconf
}
