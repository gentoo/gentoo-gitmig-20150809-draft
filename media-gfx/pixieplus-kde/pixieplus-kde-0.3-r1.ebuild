# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pixieplus-kde/pixieplus-kde-0.3-r1.ebuild,v 1.4 2002/07/23 05:18:07 seemant Exp $

inherit kde-base 

need-kde 3
DESCRIPTION="Mosfet's KDE image/photo viewer, editor, and manager"
SRC_URI="http://www.mosfet.org/pixie/${P}.tar.gz"
HOMEPAGE="http://www.mosfet.org/pixie"

SLOT="0"
# eeek! - danarmak
LICENSE="QPL-1.0 LGPL-2 BSD"
KEYWORDS="x86"

newdepend ">=kde-base/kdebase-3"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 <${FILESDIR}/pixieplus-kde-0.3-gcc31-gentoo.patch
}
