# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/eog/eog-1.1.1.ebuild,v 1.2 2002/12/03 15:15:04 nall Exp $

inherit gnome2 debug

IUSE="jpeg png"

S=${WORKDIR}/${P}
DESCRIPTION="the Eye Of Gnome - Image Viewer and Cataloger for Gnome2"
HOMEPAGE="http://www.gnome.org/"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

RDEPEND=">=dev-libs/glib-2
	>=gnome-base/gconf-1.2.1
	=gnome-base/gnome-vfs-2.1*
	=gnome-base/libgnomeui-2.1*
	=gnome-base/libbonoboui-2.1*
	=gnome-base/bonobo-activation-2.1*
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeprint-1.116.0
	=gnome-base/librsvg-2.1*
	jpeg? ( media-libs/jpeg )
	png? ( media-libs/libpng )"

DEPEND="${RDEPEND}
	dev-libs/popt
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.22"

G2CONF="${G2CONF} --enable-platform-gnome-2"
DOCS="AUTHORS ChangeLog COPYING README* INSTALL NEWS HACKING  DEPENDS THANKS  TODO"

