# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-desktop/gnome-desktop-2.2.0.1.ebuild,v 1.8 2003/07/09 16:18:34 liquidx Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="Libraries for the gnome desktop that is not part of the UI"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
KEYWORDS="x86 ppc alpha ~sparc"
LICENSE="GPL-2 FDL-1.1 LGPL-2"

RDEPEND=">=x11-libs/gtk+-2.1
	>=gnome-base/libgnomeui-2.1
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/gnome-vfs-2
	>=x11-libs/startup-notification-0.5
	app-text/scrollkeeper
	!gnome-base/gnome-core"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.22
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS ChangeLog COPYING* README INSTALL NEWS HACKING"
