# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-arch/file-roller/file-roller-1.109.ebuild,v 1.3 2002/07/18 19:49:18 spider Exp $

inherit gnome2

S=${WORKDIR}/${P}
SLOT="0"
DESCRIPTION="File Roller is an archive manager for the GNOME environment."
SRC_URI="mirror://sourceforge/${PN/-/}/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://fileroller.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

RDEPEND=">=x11-libs/gtk+-2.0.5
    >=gnome-base/gnome-vfs-2.0.0	
	>=gnome-base/libglade-2.0.0	
	>=gnome-base/bonobo-activation-1.0.0
	>=gnome-base/libbonobo-2.0.0
	>=gnome-base/nautilus-2.0.0"

DEPEND="${RDEPEND}"

DOCS="AUTHORS COPYING ChangeLog NEWS README TODO"

