# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/file-roller/file-roller-2.0.2.ebuild,v 1.6 2003/09/05 01:26:04 msterret Exp $

inherit gnome2

DESCRIPTION="archive manager for the GNOME environment"
SRC_URI="mirror://sourceforge/${PN/-/}/${P}.tar.gz"
HOMEPAGE="http://fileroller.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

DEPEND=">=x11-libs/gtk+-2.0.5
	>=gnome-base/gnome-vfs-2.0.0
	>=gnome-base/libglade-2.0.0
	>=gnome-base/bonobo-activation-1.0.0
	>=gnome-base/libbonobo-2.0.0
	>=gnome-base/nautilus-2.0.0"

DOCS="AUTHORS ChangeLog NEWS README TODO"
