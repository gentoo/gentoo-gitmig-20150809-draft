# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/quick-lounge-applet/quick-lounge-applet-0.98.ebuild,v 1.3 2003/02/13 12:23:59 vapier Exp $

inherit gnome2

S=${WORKDIR}/quick-lounge-applet-${PV}
DESCRIPTION="Application launcher applet for GNOME"
SRC_URI="mirror://sourceforge/quick-lounge/${P}.tar.gz"
HOMEPAGE="http://quick-lounge.sourceforge.net/"
IUSE=""
SLOT="2.0"
LICENSE="GPL-2"
KEYWORDS="x86"

RDEPEND="virtual/glibc
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2
	=gnome-base/libgnome-2*
	>=gnome-base/libgnomeui-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libglade-2
	>=gnome-base/gnome-panel-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog INSTALL NEWS  README"
