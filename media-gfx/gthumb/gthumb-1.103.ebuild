# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gthumb/gthumb-1.103.ebuild,v 1.1 2002/08/12 11:50:12 stroke Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="gthumb is an Image Viewer and Browser for Gnome."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://gthumb.sourceforge.net/"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

RDEPEND=">=dev-libs/glib-2.0.4
	>=x11-libs/gtk+-2.0.5
	>=dev-libs/libxml2-2.4.22
	>=gnome-base/libgnome-2.0.0
	>=gnome-base/libgnomeui-2.0.0
	>=gnome-base/libgnomecanvas-2.0.0
	>=gnome-base/gnome-vfs-2.0.0
	>=gnome-base/libglade-2.0.0
	>=gnome-base/libgnomeprint-1.115.0
	>=gnome-base/libgnomeprintui-1.115.0
	>=gnome-base/bonobo-activation-1.0.0
	>=gnome-base/libbonobo-2.0.0
	>=gnome-base/libbonoboui-2.0.0
	>=media-libs/libpng-1.2.4"

DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS COPYING ChangeLog NEWS README TODO"
src_install () {
	gnome2_src_install
	doman ${S}/doc/gthumb.1 
}
