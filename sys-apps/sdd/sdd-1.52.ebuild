# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sdd/sdd-1.52.ebuild,v 1.2 2005/01/08 10:49:01 swegener Exp $

DESCRIPTION="A fast and enhanced 'dd' replacement for UNIX"
HOMEPAGE="http://www.fokus.gmd.de/research/cc/glone/employees/joerg.schilling/private/"
SRC_URI="http://ftp.berlios.de/pub/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=""

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin ${PN}/OBJ/*/${PN} || die "dobin failed"
	doman ${PN}/${PN}.1 || die "doman failed"
}
