# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/gnome-mag/gnome-mag-0.12.2-r1.ebuild,v 1.1 2006/01/25 02:26:13 vanquirius Exp $

inherit gnome2

DESCRIPTION="Gnome magnification service definition"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-1.3.11
	>=x11-libs/gtk+-2.1
	>=gnome-base/libbonobo-1.107
	>=gnome-extra/at-spi-1.5.2
	>=gnome-base/orbit-2.3.100
	dev-libs/popt
	media-libs/libpng
	x11-libs/pango
	x11-libs/cairo
	|| (
	( >=x11-libs/libX11-1.0.0
	>=x11-libs/libICE-1.0.0
	>=x11-libs/libSM-1.0.0
	>=x11-libs/libXdamage-1.0.2.2
	>=x11-libs/libXfixes-3.0.1.2
	>=x11-proto/xextproto-7.0.2
	>=x11-proto/xproto-7.0.4
	>=x11-libs/libXt-1.0.0 )
	virtual/x11 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.28"

DOCS="AUTHORS ChangeLog NEWS README"
