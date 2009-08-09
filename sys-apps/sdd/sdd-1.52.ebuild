# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sdd/sdd-1.52.ebuild,v 1.7 2009/08/09 16:48:28 vostorga Exp $

inherit eutils

DESCRIPTION="A fast and enhanced 'dd' replacement for UNIX"
HOMEPAGE="http://ftp.berlios.de/pub/sdd/"
SRC_URI="http://ftp.berlios.de/pub/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack(){
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-glibc210.patch
}

src_compile() {
	# Can't use default src_compile, because ./configure will bail out
	emake COPTOPT="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin ${PN}/OBJ/*/${PN} || die "dobin failed"
	doman ${PN}/${PN}.1 || die "doman failed"
	dodoc README || die "dodoc failed"
}
