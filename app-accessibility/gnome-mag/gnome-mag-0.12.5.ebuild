# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/gnome-mag/gnome-mag-0.12.5.ebuild,v 1.9 2006/10/19 14:44:26 kloeri Exp $

inherit gnome2

DESCRIPTION="Gnome magnification service definition"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=dev-libs/glib-1.3.11
	>=x11-libs/gtk+-2.1
	>=gnome-base/libbonobo-1.107
	>=gnome-extra/at-spi-1.5.2
	>=gnome-base/orbit-2.3.100
	dev-libs/popt
	|| ( (
			x11-libs/libX11
			x11-libs/libXtst
			x11-libs/libXdamage
			x11-libs/libXfixes )
		virtual/x11 )"

DEPEND="${RDEPEND}
	|| ( (
			x11-proto/xextproto
			x11-proto/xproto )
		virtual/x11 )
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.34.90"

DOCS="AUTHORS ChangeLog NEWS README"
