# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/lib3ds/lib3ds-1.2.0.ebuild,v 1.8 2005/11/15 15:51:25 fmccor Exp $

DESCRIPTION="overall software library for managing 3D-Studio Release 3 and 4 .3DS files"
HOMEPAGE="http://lib3ds.sourceforge.net/"
SRC_URI="mirror://sourceforge/lib3ds/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE=""

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
