# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/yelp/yelp-2.2.2.ebuild,v 1.2 2003/06/07 15:47:41 foser Exp $

inherit gnome2

DESCRIPTION="Help browser for Gnome2"
HOMEPAGE="http://www.gnome.org/"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

RDEPEND=">=dev-libs/glib-2.0.6
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnome-2.0.2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libbonobo-2
	=gnome-extra/libgtkhtml-2.2*
	>=dev-libs/libxslt-1.0.15
	>=gnome-base/libglade-2"

DEPEND="${RDEPEND}
	dev-libs/popt
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README TODO"
