# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/gnome-mag/gnome-mag-0.10.11.ebuild,v 1.8 2004/07/22 03:25:21 lv Exp $

inherit gnome2

DESCRIPTION="Gnome magnification service definition"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="x86 ~ppc ~sparc ~mips alpha ~hppa amd64 ~ia64"
IUSE=""

RDEPEND=">=gnome-base/libbonobo-1.107
	>=gnome-base/ORBit2-2.3.100
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
