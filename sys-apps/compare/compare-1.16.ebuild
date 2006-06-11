# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/compare/compare-1.16.ebuild,v 1.2 2006/06/11 14:33:46 stuart Exp $

inherit eutils

DESCRIPTION="The fastest binary file comparison for UNIX"
HOMEPAGE="http://www.fokus.gmd.de/research/cc/glone/employees/joerg.schilling/private/"
SRC_URI="http://ftp.berlios.de/pub/${PN}/${P}.tar.bz2"
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
