# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/yelp/yelp-1.0.7.ebuild,v 1.6 2003/02/13 12:24:33 vapier Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="Yelp is a Help browser for Gnome2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~ppc alpha"

RDEPEND=">=dev-libs/glib-2.0.6
	>=gnome-base/ORBit2-2.4.1
	>=gnome-base/libgnomeui-2.0.2
	>=gnome-base/libgnome-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libbonobo-2
	>=gnome-extra/libgtkhtml-2.0.2
	>=gnome-base/gconf-1.2
	>=dev-libs/libxslt-1.0.15"
	

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README TODO"
