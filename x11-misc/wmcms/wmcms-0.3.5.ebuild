# Copyright (c) Vitaly Kushneriuk
# Distributed under the terms of the GNU General Public License, v2.
# Maintainer: Vitaly Kushneriuk<vitaly@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmcms/wmcms-0.3.5.ebuild,v 1.2 2002/01/30 21:51:46 vitaly Exp $

S=${WORKDIR}/${P}

DESCRIPTION="WindowMaker CPU / Mem Usage Monitor Dock App."
SRC_URI="http://orbita.starmedia.com/~neofpo/files/${P}.tar.bz2"
HOMEPAGE="http://orbita.starmedia.com/~neofpo/wmcms.html"
DEPEND=">=x11-libs/docklib-0.2"
#RDEPEND=""

src_compile() {
	make || die
}

src_install () {
	dobin wmcms
}
