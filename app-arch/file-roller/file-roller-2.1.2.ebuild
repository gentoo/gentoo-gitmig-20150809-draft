# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/file-roller/file-roller-2.1.2.ebuild,v 1.2 2002/10/29 14:55:07 foser Exp $

inherit gnome2 debug

S=${WORKDIR}/${P}
DESCRIPTION="File Roller is an archive manager for the GNOME environment."
HOMEPAGE="http://fileroller.sourceforge.net/"

# not in gnome/sources yet :(
SRC_URI="http://ftp.gnome.org/pub/GNOME/desktop/2.1/2.1.1/sources/${P}.tar.bz2"
#even worse, not at gnome.org at all yet
#SRC_URI="mirror://sourceforge/fileroller/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="=x11-libs/gtk+-2.1*
	>=gnome-base/gnome-vfs-2.0.4	
	>=gnome-base/libglade-2.0.1	
	=gnome-base/bonobo-activation-2.1*
	>=gnome-base/libbonobo-2
	=gnome-base/nautilus-2.1*"

DOCS="AUTHORS COPYING ChangeLog NEWS README TODO"
