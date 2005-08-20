# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/epiphany/epiphany-1.7.4.ebuild,v 1.3 2005/08/20 22:48:21 joem Exp $

inherit eutils gnome2

DESCRIPTION="GNOME webbrowser based on the mozilla rendering engine"
HOMEPAGE="http://www.gnome.org/projects/epiphany/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="dbus debug doc firefox"

RDEPEND=">=dev-libs/glib-2.8
	>=x11-libs/pango-1.8
	>=x11-libs/gtk+-2.6
	>=dev-libs/libxml2-2.6.12
	>=dev-libs/libxslt-1.1.7
	>=gnome-base/libglade-2.3.1
	>=gnome-base/gnome-vfs-2.9.2
	>=gnome-base/libgnomeui-2.6.0
	>=gnome-base/gnome-desktop-2.9.91
	>=x11-libs/startup-notification-0.5
	>=gnome-base/libbonobo-2.2
	>=gnome-base/orbit-2
	>=gnome-base/gconf-2
	>=app-text/gnome-doc-utils-0.3.2
	>=app-text/iso-codes-0.47
	!firefox? ( >=www-client/mozilla-1.7.3 )
	firefox? ( >=www-client/mozilla-firefox-1.0.2-r1 )
	dbus? ( >=sys-apps/dbus-0.22 )
	x11-themes/gnome-icon-theme"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	dev-util/pkgconfig
	>=dev-util/intltool-0.29
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS README TODO"

MAKEOPTS="${MAKEOPTS} -j1"

USE_DESTDIR="1"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix include paths for our mozilla
	epatch ${FILESDIR}/${P}-configure.patch
	epatch ${FILESDIR}/${P}-includes.patch
}

src_compile() {
	G2CONF="${G2CONF} $(use_enable dbus) --disable-scrollkeeper"

	if use firefox; then
		G2CONF="${G2CONF} --with-mozilla=firefox"
	else
		G2CONF="${G2CONF} --with-mozilla=mozilla"
	fi

	gnome2_src_compile
}
