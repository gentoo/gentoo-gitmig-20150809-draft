# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/eog/eog-0.119.ebuild,v 1.1 2002/06/05 16:30:45 spider Exp $

 

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="the Eye Of Gnome - Image Viewer and Cataloger for Gnome2"
SRC_URI="ftp://ftp.gnome.org/pub/gnome/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="1"
LICENSE="GPL-2"

RDEPEND=">=dev-libs/glib-2.0.0
	>=gnome-base/gconf-1.1.8
	>=x11-libs/gtk+-2.0.0
	>=dev-libs/libxml2-2.4.17
	>=gnome-base/gnome-vfs-1.9.10
	>=gnome-base/libgnomeui-1.112.1
	>=gnome-base/libbonoboui-1.112.1
	>=gnome-base/bonobo-activation-0.9.5
	>=gnome-base/libgnomecanvas-1.113.0
	>=gnome-base/libgnomeprint-1.111.0
	>=sys-libs/zlib-1.1.4
	>=media-libs/libpng-1.2.1"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.17"


LIBTOOL_FIX="1"
G2CONF="${G2CONF} --enable-platform-gnome-2" 

DOCS="AUTHORS ChangeLog COPYING README* INSTALL NEWS HACKING  DEPENDS THANKS  TODO"

SCHEMAS="eog.schemas"

