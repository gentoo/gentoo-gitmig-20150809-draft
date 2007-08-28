# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/gnome-mag/gnome-mag-0.14.3.ebuild,v 1.8 2007/08/28 18:16:38 jer Exp $

inherit gnome2

DESCRIPTION="Gnome magnification service definition"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="alpha amd64 hppa ia64 ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/glib-2.11.1
	>=x11-libs/gtk+-2.1
	>=gnome-base/libbonobo-1.107
	>=gnome-extra/at-spi-1.5.2
	>=gnome-base/orbit-2.3.100

	x11-libs/libX11
	x11-libs/libXtst
	x11-libs/libXdamage
	x11-libs/libXfixes
	x11-libs/libXcomposite"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.35

	x11-proto/xextproto
	x11-proto/xproto"

DOCS="AUTHORS ChangeLog NEWS README"
