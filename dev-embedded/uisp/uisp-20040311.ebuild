# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/uisp/uisp-20040311.ebuild,v 1.2 2004/03/23 02:33:49 dragonheart Exp $

DESCRIPTION="Uisp is a tool for AVR microcontrollers which can interface to many hardware in-system programmers"
SRC_URI="http://savannah.nongnu.org/download/uisp/${P}.tar.bz2"
HOMEPAGE="http://savannah.nongnu.org/projects/uisp"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="sys-apps/gawk
	sys-devel/gcc"

RDEPEND=""

S=${WORKDIR}/${P}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc doc/*
	prepalldocs
}
