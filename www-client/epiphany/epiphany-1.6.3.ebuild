# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/epiphany/epiphany-1.6.3.ebuild,v 1.9 2005/08/23 21:00:35 agriffis Exp $

inherit eutils gnome2

DESCRIPTION="GNOME webbrowser based on the mozilla rendering engine"
HOMEPAGE="http://www.gnome.org/projects/epiphany/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ia64 ppc ~ppc64 sparc x86"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2.6
	>=x11-libs/pango-1.8
	>=x11-libs/gtk+-2.6.3
	>=gnome-base/gconf-1.2
	>=dev-libs/libxml2-2.6.12
	>=dev-libs/libxslt-1.1.7
	>=gnome-base/libgnomeui-2.6.0
	>=gnome-base/libglade-2.3.1
	>=gnome-base/libbonoboui-2.2
	>=gnome-base/orbit-2
	>=gnome-base/gnome-vfs-2.9.2
	>=gnome-base/gnome-desktop-2.9.91
	|| ( >=www-client/mozilla-1.7.3
		 >=www-client/mozilla-firefox-1.0.2-r1 )
	>=x11-themes/gnome-icon-theme-2.9.3
	>=x11-libs/startup-notification-0.5"
# dbus? ( >=sys-apps/dbus-0.22 )

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	dev-util/pkgconfig
	>=dev-util/intltool-0.29
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README TODO"

MAKEOPTS="${MAKEOPTS} -j1"

USE_DESTDIR="1"

# Mozilla/Firefox DEPEND on >=gtk+-2 now, no need
# to check it <obz@gentoo.org>

src_unpack() {

	unpack ${A}
	cd ${S}
	# Fix include paths for our mozilla
	epatch ${FILESDIR}/${P}-fix_includes.patch
}
