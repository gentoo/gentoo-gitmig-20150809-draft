# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/evince/evince-2.20.1.ebuild,v 1.14 2009/03/07 14:47:36 gentoofan23 Exp $

WANT_AUTOMAKE="1.9"
EAPI="2"
inherit eutils gnome2 autotools

DESCRIPTION="Simple document viewer for GNOME"
HOMEPAGE="http://www.gnome.org/projects/evince/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="arm sh"
IUSE="dbus djvu doc dvi gnome t1lib tiff"

RDEPEND="
	dbus? ( >=dev-libs/dbus-glib-0.71 )
	>=x11-libs/gtk+-2.10
	gnome-base/gnome-keyring
	>=gnome-base/libgnomeui-2.14
	>=gnome-base/libgnome-2.14
	dev-libs/libxml2
	>=x11-themes/gnome-icon-theme-2.17.1
	>=gnome-base/gnome-vfs-2.0
	>=gnome-base/libglade-2
	>=dev-libs/glib-2
	gnome? ( >=gnome-base/nautilus-2.10 )
	<app-text/poppler-bindings-0.8[gtk]
	dvi? (
		virtual/tex-base
		t1lib? ( >=media-libs/t1lib-5.0.0 )
	)
	tiff? ( >=media-libs/tiff-3.6 )
	>=gnome-base/gconf-2
	djvu? ( >=app-text/djvu-3.5.17 )
	virtual/ghostscript"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=app-text/gnome-doc-utils-0.3.2
	~app-text/docbook-xml-dtd-4.1.2
	>=dev-util/pkgconfig-0.9
	>=sys-devel/automake-1.9
	>=dev-util/intltool-0.35"

DOCS="AUTHORS ChangeLog NEWS README TODO"
USE_DESTDIR="1"
ELTCONF="--portage"
RESTRICT="test"

pkg_setup() {
	G2CONF="--disable-scrollkeeper \
		--enable-comics		\
		--enable-impress	\
		$(use_enable dbus)  \
		$(use_enable djvu)  \
		$(use_enable dvi)   \
		$(use_enable t1lib) \
		$(use_enable tiff)  \
		$(use_enable gnome nautilus)"
}

src_unpack() {
	gnome2_src_unpack

	# Fix .desktop file so menu item shows up
	epatch "${FILESDIR}"/${PN}-0.7.1-display-menu.patch

	# Make dbus actually switchable
	epatch "${FILESDIR}"/${PN}-0.6.1-dbus-switch.patch

	cp aclocal.m4 old_macros.m4
	AT_M4DIR="." eautoreconf
}
