# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/eog/eog-1.0.3.ebuild,v 1.4 2002/09/21 12:09:35 bjb Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="the Eye Of Gnome - Image Viewer and Cataloger for Gnome2"
SRC_URI="mirror://gnome/2.0.1/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64 ppc alpha"

RDEPEND=">=dev-libs/glib-2.0.6
	>=gnome-base/gconf-1.2.1
	>=x11-libs/gtk+-2.0.6
	>=dev-libs/libxml2-2.4.24
	>=gnome-base/gnome-vfs-2.0.4
	>=gnome-base/libgnomeui-2.0.5
	>=gnome-base/libbonoboui-2.0.3
	>=gnome-base/bonobo-activation-1.0.3
	>=gnome-base/libgnomecanvas-2.0.4
	>=gnome-base/libgnomeprint-1.116.0
	>=gnome-base/librsvg-2.0.1
	>=sys-libs/zlib-1.1.4
	>=media-libs/libpng-1.2.1"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.22"

G2CONF="${G2CONF} --enable-platform-gnome-2"
DOCS="AUTHORS ChangeLog COPYING README* INSTALL NEWS HACKING  DEPENDS THANKS  TODO"

