# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/evince/evince-2.26.2.ebuild,v 1.9 2010/07/20 02:51:29 jer Exp $

EAPI="2"

inherit eutils gnome2

DESCRIPTION="Simple document viewer for GNOME"
HOMEPAGE="http://www.gnome.org/projects/evince/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="dbus debug djvu doc dvi gnome-keyring nautilus t1lib tiff"

# FIXME: enable gobject-introspection when we have an ebuild for it.
# Since 2.26.2, can handle poppler without cairo support. Make it optional ?
RDEPEND="
	>=app-text/libspectre-0.2.0
	>=dev-libs/glib-2.18.0
	>=dev-libs/libxml2-2.5
	>=gnome-base/gconf-2
	>=x11-libs/gtk+-2.12
	>=x11-libs/libSM-1
	>=x11-themes/gnome-icon-theme-2.17.1
	dbus? ( >=dev-libs/dbus-glib-0.71 )
	gnome-keyring? ( >=gnome-base/gnome-keyring-2.22.0 )
	nautilus? ( >=gnome-base/nautilus-2.10 )
	>=app-text/poppler-0.12.3-r3[cairo]
	dvi? (
		virtual/tex-base
		t1lib? ( >=media-libs/t1lib-5.0.0 ) )
	tiff? ( >=media-libs/tiff-3.6 )
	djvu? ( >=app-text/djvu-3.5.17 )"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=app-text/gnome-doc-utils-0.3.2
	~app-text/docbook-xml-dtd-4.1.2
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.35
	doc? ( dev-util/gtk-doc )"

DOCS="AUTHORS ChangeLog NEWS README TODO"
ELTCONF="--portage"
RESTRICT="test"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-scrollkeeper
		--disable-introspection
		--enable-pdf
		--enable-comics
		--enable-impress
		--enable-thumbnailer
		--with-gconf
		$(use_enable dbus)
		$(use_enable djvu)
		$(use_enable dvi)
		$(use_with gnome-keyring keyring)
		$(use_enable t1lib)
		$(use_enable tiff)
		$(use_enable nautilus)"
}

src_prepare() {
	gnome2_src_prepare

	# Fix .desktop file so menu item shows up
	epatch "${FILESDIR}"/${PN}-0.7.1-display-menu.patch
}
