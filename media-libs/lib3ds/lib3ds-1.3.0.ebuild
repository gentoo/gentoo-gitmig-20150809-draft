# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/lib3ds/lib3ds-1.3.0.ebuild,v 1.1 2008/01/04 19:50:54 nyhm Exp $

DESCRIPTION="library for managing 3D-Studio Release 3 and 4 .3DS files"
HOMEPAGE="http://lib3ds.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="virtual/glut
	virtual/opengl"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README
}
