# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gnote/gnote-0.7.4.ebuild,v 1.5 2012/05/22 11:20:08 ago Exp $

EAPI="3"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="Desktop note-taking application"
HOMEPAGE="http://live.gnome.org/Gnote"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="applet debug" # dbus

RDEPEND=">=x11-libs/gtk+-2.20:2
	>=dev-cpp/glibmm-2.18:2
	>=dev-cpp/gtkmm-2.12:2.4
	>=dev-libs/libxml2-2:2
	dev-libs/libxslt
	>=gnome-base/gconf-2:2
	>=dev-libs/libpcre-7.8:3[cxx]
	>=app-text/gtkspell-2.0.9:2
	>=dev-libs/boost-1.34
	sys-libs/e2fsprogs-libs
	applet? (
		>=gnome-base/gnome-panel-2
		<gnome-base/gnome-panel-2.91
		>=dev-cpp/libpanelappletmm-2.26:2.6 )"
# Build with dbus is currently not implemented
#	dbus? ( >=dev-libs/dbus-glib-0.70 )"
DEPEND="${DEPEND}
	virtual/pkgconfig
	>=dev-util/intltool-0.35.0
	app-text/gnome-doc-utils
	app-text/docbook-xml-dtd:4.1.2"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	G2CONF="${G2CONF}
		--disable-dbus
		--disable-static
		$(use_enable applet)
		$(use_enable debug)"
}

src_prepare() {
	gnome2_src_prepare

	# Do not set idiotic defines in a released tarball, bug #311979
	sed 's/-DG.*_DISABLE_DEPRECATED//g' -i libtomboy/Makefile.am \
		libtomboy/Makefile.in || die "sed failed"
}
