# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/workrave/workrave-1.8.3.ebuild,v 1.6 2007/07/12 03:35:11 mr_bones_ Exp $

inherit eutils gnome2

DESCRIPTION="Helpful utility to attack Repetitive Strain Injury (RSI)"
HOMEPAGE="http://workrave.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="arts distribution gnome kde nls xml"

# configure.ac checks for dbus but the code doesn't actually use it
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
	xml? ( dev-libs/gdome2 )
	kde? (
		=x11-libs/qt-3*
		kde-base/kdelibs )
	arts? ( kde-base/arts )
	|| ( (
			x11-libs/libX11
			x11-libs/libXt
			x11-libs/libXmu )
		virtual/x11 )"

DEPEND="${RDEPEND}
	|| ( (
			x11-proto/xproto
			x11-proto/inputproto
			x11-proto/recordproto )
		virtual/x11 )
	nls? ( sys-devel/gettext )
	>=dev-util/pkgconfig-0.9"

MAKEOPTS="${MAKEOPTS} -j1"
DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	G2CONF="--enable-gconf \
		$(use_enable distribution)  \
		$(use_enable nls)           \
		$(use_enable xml)           \
		$(use_enable gnome)         \
		$(use_enable gnome gnomemm) \
		$(use_enable kde)           \
		$(use_with arts)"
}

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# Removes a few broken macros. See bug #86939.
	epatch "${FILESDIR}"/${PN}-1.6.2-nls_macros.patch
}

src_compile() {
	if use kde; then
		addwrite "/usr/qt/3/etc/settings"
		export KDEDIR=$(kde-config --prefix)
		einfo "KDEDIR set to ${KDEDIR}"
	fi

	gnome2_src_compile
}
