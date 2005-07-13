# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/gnome-mag/gnome-mag-0.10.11.ebuild,v 1.15 2005/07/13 05:31:32 geoman Exp $

inherit gnome2

DESCRIPTION="Gnome magnification service definition"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="alpha amd64 hppa ~ia64 ppc sparc x86"
IUSE=""

RDEPEND=">=gnome-base/libbonobo-1.107
	>=gnome-base/orbit-2.4
	>=gnome-extra/at-spi-0.12.1
	>=dev-libs/glib-1.3.11
	>=x11-libs/gtk+-2.1
	dev-libs/popt
	virtual/x11"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

MAKEOPTS="${MAKEOPTS} -j1"

DOCS="AUTHORS ChangeLog NEWS README"
