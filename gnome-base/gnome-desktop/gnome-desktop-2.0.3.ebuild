# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-desktop/gnome-desktop-2.0.3.ebuild,v 1.1 2002/07/15 13:36:05 stroke Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="Libraries considered too unstable for libgnomeui"
SRC_URI="mirror://gnome/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2 FDL-1.1 LGPL-2.1"


RDEPEND=">=gnome-base/libgnomeui-2.0.1
		>=gnome-base/libgnomecanvas-2.0.1
		>=x11-libs/gtk+-2.0.5
		>=gnome-base/gnome-vfs-2.0.0
		!gnome-base/gnome-core"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.17
	>=dev-util/pkgconfig-0.12.0"
DOCS="AUTHORS ChangeLog COPYING*  README* INSTALL NEWS HACKING"

