# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/yelp/yelp-0.10.ebuild,v 1.3 2002/07/25 04:45:32 spider Exp $

inherit gnome2 

S=${WORKDIR}/${P}
DESCRIPTION="Yelp is a Help browser for Gnome2"
SRC_URI="mirror://gnome/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL"
KEYWORDS="x86"

RDEPEND=">=gnome-base/ORBit2-2.4.0
	>=gnome-base/libgnomeui-1.117.2
	>=gnome-base/libgnome-1.117.2
	>=gnome-base/gnome-vfs-1.9.10
	>=gnome-base/libbonobo-1.112.0
	>=gnome-extra/libgtkhtml-1.99.9
	>=dev-libs/libxslt-1.0.15"
	

DEPEND="${DEPEND}
	>=dev-util/pkgconfig-0.12.0"

LIBTOOL_FIX="1"
G2CONF="${G2CONF} --enable-platform-gnome-2"
DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README TODO"

