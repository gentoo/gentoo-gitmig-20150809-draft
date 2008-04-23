# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/picprog/picprog-1.8.3.ebuild,v 1.2 2008/04/23 07:24:50 calchan Exp $

DESCRIPTION="A PIC16, PIC18 and dsPIC microcontroller programmer software for the serial port."
HOMEPAGE="http://www.iki.fi/hyvatti/pic/picprog.html"
SRC_URI="http://www.iki.fi/hyvatti/pic/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND=""

src_unpack() {
	unpack ${A}
	sed -i \
		-e 's/<string>/<string.h>/' \
		-e '/<iostream>/ i\
#include <cstdlib>' \
		"${S}"/program.cc || die "sed failed"
}

src_compile() {
	emake CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" || die "Compilation failed"
}

src_install() {
	dobin picprog || die "Installation failed"
	dodoc README
	dohtml picprog.html *.png
	doman picprog.1
}
