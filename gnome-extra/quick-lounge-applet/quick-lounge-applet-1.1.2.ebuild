# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/quick-lounge-applet/quick-lounge-applet-1.1.2.ebuild,v 1.4 2003/05/05 11:39:22 foser Exp $

inherit gnome2

S=${WORKDIR}/quick-lounge-applet-${PV}
DESCRIPTION="Application launcher applet for GNOME"
SRC_URI="mirror://sourceforge/quick-lounge/${P}.tar.gz"
HOMEPAGE="http://quick-lounge.sourceforge.net/"
IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

RDEPEND=">=dev-libs/glib-2.1
	>=x11-libs/gtk+-2.1.1
	>=gnome-base/libgnome-2.1.1
	>=gnome-base/libgnomeui-2.1.1
	>=gnome-base/gnome-desktop-2.1
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libglade-2
	>=gnome-base/gnome-panel-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

DOCS="AUTHORS ChangeLog INSTALL NEWS README"
