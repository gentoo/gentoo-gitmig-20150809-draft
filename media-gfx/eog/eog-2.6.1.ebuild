# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/eog/eog-2.6.1.ebuild,v 1.5 2004/07/31 03:55:04 spider Exp $

inherit gnome2

DESCRIPTION="Eye Of Gnome, an image viewer"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2"

SLOT="1"
IUSE="jpeg"
KEYWORDS="x86 ~ppc ~alpha ~sparc ~hppa amd64 ~ia64 ~mips ppc64"

RDEPEND=">=x11-libs/gtk+-2.4
	>=gnome-base/gconf-2.6
	dev-libs/popt
	>=gnome-base/gnome-vfs-2.6
	>=gnome-base/libgnomeui-2.6
	>=gnome-base/libgnomecanvas-2.6
	>=gnome-base/libbonobo-2.6
	>=gnome-base/libbonoboui-2.6
	>=gnome-base/libglade-2.3.6
	>=media-libs/libart_lgpl-2.3.16
	>=gnome-base/libgnomeprintui-2.6
	>=gnome-base/eel-2.6
	jpeg? ( >=media-libs/libexif-0.5.12
		media-libs/jpeg )"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.12.0"

G2CONF="${G2CONF} $(use_with jpeg libjpeg) $(use_with jpeg libexif)"

DOCS="AUTHORS ChangeLog COPYING README INSTALL NEWS HACKING DEPENDS THANKS TODO"
