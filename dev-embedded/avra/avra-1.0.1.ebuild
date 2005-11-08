# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/avra/avra-1.0.1.ebuild,v 1.1 2005/11/08 21:45:02 pylon Exp $

DESCRIPTION="Atmel AVR Assembler"
HOMEPAGE="http://avra.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="doc"

DEPEND=""
RDEPEND=""

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${A}
}

src_compile() {
	cd ${S}/SOURCE
	make all
}

src_install() {
	cd ${S}/SOURCE
	into /usr
	dobin avra

	cd ${S}
	into /usr
	dodoc COPYING ChangeLog README

	if use doc ; then
		docinto TEST
		dodoc TEST/*
	fi
}
