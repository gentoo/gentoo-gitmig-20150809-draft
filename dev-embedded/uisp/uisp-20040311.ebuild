# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/uisp/uisp-20040311.ebuild,v 1.4 2004/06/29 13:27:34 vapier Exp $

DESCRIPTION="tool for AVR microcontrollers which can interface to many hardware in-system programmers"
HOMEPAGE="http://savannah.nongnu.org/projects/uisp"
SRC_URI="http://savannah.nongnu.org/download/uisp/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-apps/gawk
	sys-devel/gcc"
RDEPEND=""

src_install() {
	make DESTDIR=${D} install || die
	dodoc doc/*
	prepalldocs
}
