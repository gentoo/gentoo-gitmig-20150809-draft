# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/eog/eog-2.3.90.ebuild,v 1.2 2003/09/08 05:09:18 msterret Exp $

inherit gnome2

IUSE="jpeg"

DESCRIPTION="the Eye Of Gnome - Image Viewer and Cataloger for Gnome2"
HOMEPAGE="http://www.gnome.org/"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~amd64"

RDEPEND=">=x11-libs/gtk+-2.2.1
	>=gnome-base/gconf-2.2
	>=gnome-base/gnome-vfs-2.2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/libgnomecanvas-2

	>=gnome-base/libbonoboui-2.3.3

	>=gnome-base/libglade-2.0.1
	>=gnome-base/librsvg-2.3
	>=gnome-base/eel-2.2
	>=media-libs/libart_lgpl-2.2

	>=gnome-base/libgnomeprintui-2.2.1.1
	jpeg? ( >=media-libs/libexif-0.5.10
		media-libs/jpeg )"

DEPEND="${RDEPEND}
	dev-libs/popt
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS ChangeLog COPYING README INSTALL NEWS HACKING DEPENDS THANKS  TODO"

use jpeg \
	&& G2CONF="${G2CONF} --with-libjpeg" \
	|| G2CONF="${G2CONF} --without-libjpeg"

