# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-desktop/gnome-desktop-2.0.8.ebuild,v 1.3 2002/09/21 12:09:35 bjb Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="Libraries for the gnome desktop that is not part of the UI"
SRC_URI="mirror://gnome/2.0.1/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
KEYWORDS="x86 ppc sparc sparc64 alpha"
LICENSE="GPL-2 FDL-1.1 LGPL-2.1"

RDEPEND=">=gnome-base/libgnomeui-2.0.5
		>=gnome-base/libgnomecanvas-2.0.4
		>=x11-libs/gtk+-2.0.6
		>=gnome-base/gnome-vfs-2.0.4
		!gnome-base/gnome-core"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.22
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS ChangeLog COPYING*  README* INSTALL NEWS HACKING"


