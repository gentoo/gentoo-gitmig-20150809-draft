# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pixieplus-kde/pixieplus-kde-0.3-r1.ebuild,v 1.3 2002/07/11 06:30:27 drobbins Exp $

inherit kde-base 

need-kde 3
DESCRIPTION="Mosfet's KDE image/photo viewer, editor, and manager"
SRC_URI="http://www.mosfet.org/pixie/${P}.tar.gz"
HOMEPAGE="http://www.mosfet.org/pixie"
# eeek! - danarmak
LICENSE="pixieplus LGPL-2 BSD" # QPL too?

newdepend ">=kde-base/kdebase-3"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 <${FILESDIR}/pixieplus-kde-0.3-gcc31-gentoo.patch
}

