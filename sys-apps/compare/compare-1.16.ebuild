# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/compare/compare-1.16.ebuild,v 1.3 2007/07/16 14:57:54 armin76 Exp $

inherit eutils

DESCRIPTION="The fastest binary file comparison for UNIX"
HOMEPAGE="http://developer.berlios.de/projects/compare/"
SRC_URI="mirror://berlios/pub/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""
DEPEND="!media-gfx/imagemagick"

src_compile() {
	make
}

src_install() {
	OBJ=${PN}/OBJ/`ls ${PN}/OBJ`
	dobin ${OBJ}/${PN}
	doman ${PN}/${PN}.1
}
