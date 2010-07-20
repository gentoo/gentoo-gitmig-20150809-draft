# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/gok/gok-2.26.0.ebuild,v 1.11 2010/07/20 01:55:29 jer Exp $

EAPI=1
inherit virtualx gnome2

DESCRIPTION="Gnome Onscreen Keyboard"
HOMEPAGE="http://www.gok.ca/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="accessibility doc usb"

# accessibility will disappear with new xorg-server (1.6)
RDEPEND=">=dev-libs/glib-2.17.4
	>=gnome-base/libgnomeui-2
	>=gnome-extra/at-spi-1.5.2
	>=gnome-base/libbonobo-2.5.1
	>=dev-libs/atk-1.3
	>=x11-libs/gtk+-2.13.0
	>=x11-libs/libwnck-2.13.5
	app-accessibility/gnome-speech
	media-sound/esound
	>=gnome-base/libglade-2
	>=gnome-base/gconf-2
	>=gnome-base/orbit-2
	usb? ( =virtual/libusb-0* )
	x11-libs/libXi
	x11-libs/libX11
	accessibility? ( x11-libs/libXevie )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40.1
	>=dev-util/pkgconfig-0.9
	app-text/scrollkeeper
	doc? ( >=dev-util/gtk-doc-1 )
	x11-proto/inputproto
	x11-proto/kbproto
	x11-proto/xproto"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable usb libusb-input)
		$(use_enable accessibility xevie)"
}

src_test() {
	addwrite "/root/.gnome2_private"
	Xmake check || die "test failed"
}
