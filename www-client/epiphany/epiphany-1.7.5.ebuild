# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/epiphany/epiphany-1.7.5.ebuild,v 1.1 2005/08/26 07:44:07 leonardop Exp $

inherit eutils gnome2

DESCRIPTION="GNOME webbrowser based on the mozilla rendering engine"
HOMEPAGE="http://www.gnome.org/projects/epiphany/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE="dbus doc firefox python"

RDEPEND=">=dev-libs/glib-2.7
	>=x11-libs/pango-1.8
	>=x11-libs/gtk+-2.6.3
	>=dev-libs/libxml2-2.6.12
	>=dev-libs/libxslt-1.1.7
	>=gnome-base/libglade-2.3.1
	>=gnome-base/gnome-vfs-2.9.2
	>=gnome-base/libgnomeui-2.6
	>=gnome-base/gnome-desktop-2.9.91
	>=x11-libs/startup-notification-0.5
	>=gnome-base/libgnomeprint-2.4
	>=gnome-base/libgnomeprintui-2.4
	>=gnome-base/libbonobo-2
	>=gnome-base/orbit-2
	>=gnome-base/gconf-2
	>=app-text/gnome-doc-utils-0.3.2
	>=app-text/iso-codes-0.35
	!firefox? ( >=www-client/mozilla-1.7.3 )
	firefox? ( >=www-client/mozilla-firefox-1.0.2-r1 )
	dbus? ( >=sys-apps/dbus-0.22 )
	python? (
		>=dev-lang/python-2.3
		>=dev-python/pygtk-2.7
		>=dev-python/gnome-python-2.6 )
	x11-themes/gnome-icon-theme"
# pygtk dependency needs to be >= 2.7

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.29
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog* HACKING MAINTAINERS NEWS README TODO"
USE_DESTDIR="1"

MAKEOPTS="${MAKEOPTS} -j1"


pkg_setup() {
	G2CONF="$(use_enable dbus) $(use_enable python) --disable-scrollkeeper"

	if use firefox; then
		G2CONF="${G2CONF} --with-mozilla=firefox"
	else
		G2CONF="${G2CONF} --with-mozilla=mozilla"
	fi
}

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# Fix include paths for our mozilla
	epatch ${FILESDIR}/${PN}-1.7.4-includes.patch
}
