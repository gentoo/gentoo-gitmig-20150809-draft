# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/uisp/uisp-20030618.ebuild,v 1.3 2004/03/23 18:41:40 dragonheart Exp $

DESCRIPTION="Uisp is a tool for AVR microcontrollers which can interface to many hardware in-system programmers"
SRC_URI="http://savannah.nongnu.org/download/uisp/${P}.tar.gz"
HOMEPAGE="http://savannah.nongnu.org/projects/uisp"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=""

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc doc/*
	prepalldocs
}
