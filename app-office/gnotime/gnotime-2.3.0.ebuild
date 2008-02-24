# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gnotime/gnotime-2.3.0.ebuild,v 1.1 2008/02/24 23:47:12 eva Exp $

EAPI="1"

inherit eutils gnome2 autotools

DESCRIPTION="utility to track time spent on activities"
HOMEPAGE="http://gttr.sourceforge.net/"
SRC_URI="mirror://sourceforge/gttr/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~sparc ~x86"
IUSE=""
RESTRICT="test"

RDEPEND=">=x11-libs/gtk+-2.10
	>=dev-libs/glib-2.14
	>=gnome-base/libgnome-2.0
	>=gnome-base/libgnomeui-2.0.3
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libglade-2.0
	>=gnome-extra/gtkhtml-3.14.3:3.14
	>=gnome-base/gconf-2.0
	x11-libs/pango
	dev-libs/libxml2
	>=dev-libs/dbus-glib-0.74
	dev-scheme/guile
	dev-libs/popt"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	=app-text/docbook-xml-dtd-4.2*
	>=app-text/scrollkeeper-0.3.11
	dev-libs/qof"

DOCS="AUTHORS ChangeLog NEWS README TODO"

# Fix for bug #109047, don't parallel build with libqofsql
# Should be fixed, to be tested
#MAKEOPTS="${MAKEOPTS} -j1"

pkg_setup() {
	G2CONF="${G2CONF} --disable-schemas-install"

	# upstream knows about the fix and has promised to incorporate it
	if ! built_with_use --missing true dev-scheme/guile deprecated;then
		   eerror "rebuild dev-scheme/guile with USE=deprecated"
		   die
	fi
}
