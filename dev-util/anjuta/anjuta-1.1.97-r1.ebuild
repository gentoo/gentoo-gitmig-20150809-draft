# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/anjuta/anjuta-1.1.97-r1.ebuild,v 1.1 2003/10/07 18:04:58 lisa Exp $

# development version
inherit gnome2 debug

DESCRIPTION="A versatile IDE for GNOME"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://anjuta.sourceforge.net/"

IUSE="sdl wxwindows"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc -amd64"



RDEPEND=">=dev-libs/glib-2.0.6
	>=x11-libs/gtk+-2.2.0
	>=dev-util/devhelp-0.6
	>=dev-util/glade-2
	>=gnome-base/libglade-2
	>=dev-util/glademm-2
	sdl? ( >=media-libs/libsdl-1.2 )
	wxwindows? ( x11-libs/wxGTK )
	app-text/scrollkeeper"

DEPEND="${DEPEND}
	dev-util/pkgconfig
	>=x11-libs/libzvt-2.0.1
	>=dev-libs/libpcre-3.9"


DOCS="AUTHORS COPYING ChangeLog FUTURE NEWS README THANKS TODO"
