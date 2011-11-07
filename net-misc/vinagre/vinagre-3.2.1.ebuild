# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vinagre/vinagre-3.2.1.ebuild,v 1.1 2011/11/07 05:04:22 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools eutils gnome2

DESCRIPTION="VNC Client for the GNOME Desktop"
HOMEPAGE="http://www.gnome.org/projects/vinagre/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="avahi +ssh +telepathy test"

# cairo used in vinagre-tab
# gdk-pixbuf used all over the place
RDEPEND=">=dev-libs/glib-2.28.0:2
	>=x11-libs/gtk+-3.0.3:3
	>=gnome-base/gnome-keyring-1
	>=dev-libs/libxml2-2.6.31:2
	>=net-libs/gtk-vnc-0.4.3[gtk3]
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-themes/gnome-icon-theme

	avahi? ( >=net-dns/avahi-0.6.26[dbus,gtk3] )
	ssh? ( >=x11-libs/vte-0.20:2.90 )
	telepathy? (
		dev-libs/dbus-glib
		>=net-libs/telepathy-glib-0.11.6 )
"
DEPEND="${RDEPEND}
	dev-lang/vala:0.12
	gnome-base/gnome-common
	>=dev-lang/perl-5
	>=dev-util/pkgconfig-0.16
	>=dev-util/intltool-0.40
	app-text/scrollkeeper
	app-text/gnome-doc-utils
	>=sys-devel/gettext-0.17
	test? ( ~app-text/docbook-xml-dtd-4.3 )"

pkg_setup() {
	DOCS="AUTHORS ChangeLog ChangeLog.pre-git NEWS README"
	# Spice support?
	G2CONF="${G2CONF}
		VALAC=$(type -p valac-0.12)
		--disable-schemas-compile
		--disable-scrollkeeper
		--disable-spice
		--enable-rdp
		$(use_with avahi)
		$(use_enable ssh)
		$(use_with telepathy)"
}

src_prepare() {
	# Useful patches from upstream, will be in next release
	epatch "${FILESDIR}/${P}-hold-slave-pty-open.patch"
	epatch "${FILESDIR}/${P}-authenticate-button.patch"

	# https://bugzilla.gnome.org/show_bug.cgi?id=660531
	epatch "${FILESDIR}/${PN}-3.2.1-implicit-function-declarations.patch"
	eautoreconf
	gnome2_src_prepare
}

src_install() {
	gnome2_src_install

	# Remove its own installation of DOCS that go to $PN instead of $P and aren't ecompressed
	rm -rf "${ED}"/usr/share/doc/vinagre
}
