# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/yelp/yelp-0.10.ebuild,v 1.11 2003/05/29 14:36:10 liquidx Exp $

inherit gnome2 

DESCRIPTION="Help browser for Gnome2"
SRC_URI="mirror://gnome/2.0.0/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"

RDEPEND=">=gnome-base/ORBit2-2.4.0
	>=gnome-base/libgnomeui-1.117.2
	>=gnome-base/libgnome-1.117.2
	>=gnome-base/gnome-vfs-1.9.10
	>=gnome-base/libbonobo-1.112.0
	=gnome-extra/libgtkhtml-2*
	>=dev-libs/libxslt-1.0.15"
DEPEND="${DEPEND}
	>=dev-util/pkgconfig-0.12.0"

LIBTOOL_FIX="1"
G2CONF="${G2CONF} --enable-platform-gnome-2"
DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README TODO"
