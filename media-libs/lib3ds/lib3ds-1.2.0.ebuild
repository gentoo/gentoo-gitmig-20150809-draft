# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/lib3ds/lib3ds-1.2.0.ebuild,v 1.3 2003/02/13 12:46:34 vapier Exp $

DESCRIPTION="overall software library for managing 3D-Studio Release 3 and 4 .3DS files"
HOMEPAGE="http://lib3ds.sourceforge.net/"
SRC_URI="mirror://sourceforge/lib3ds/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/glut
	virtual/opengl"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dobin examples/3ds2rib || die
	newbin examples/player 3dsplayer || die
	dodoc README AUTHORS
}
