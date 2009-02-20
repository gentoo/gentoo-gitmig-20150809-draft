# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vinagre/vinagre-0.5.2.ebuild,v 1.9 2009/02/20 03:50:50 ford_prefect Exp $

inherit gnome2 eutils

DESCRIPTION="VNC Client for the GNOME Desktop"
HOMEPAGE="http://www.gnome.org/projects/vinagre/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="avahi test"

RDEPEND=">=dev-libs/glib-2.15.3
	>=x11-libs/gtk+-2.12
	>=gnome-base/libglade-2.6
	>=gnome-base/gconf-2.16
	>=net-libs/gtk-vnc-0.3.3
	>=gnome-base/gnome-keyring-1
	avahi? ( >=net-dns/avahi-0.6.18 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.35
	app-text/scrollkeeper
	app-text/gnome-doc-utils
	test? ( ~app-text/docbook-xml-dtd-4.3 )"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"

pkg_setup() {
	if use avahi && ! built_with_use net-dns/avahi dbus gtk; then
		eerror "DBus and GTK support are needed in Avahi"
		eerror "Please rebuild net-dns/avahi with USE='dbus gtk'"
		die "Missing USE flags for net-dns/avahi"
	fi

	G2CONF="${G2CONF} $(use_enable avahi) --disable-scrollkeeper"
}

src_install() {
	gnome2_src_install

	# Remove it's own installation of DOCS that go to $PN instead of $P and aren't ecompressed
	rm -rf "${D}"/usr/share/doc/vinagre
}
