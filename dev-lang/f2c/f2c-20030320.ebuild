# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/f2c/f2c-20030320.ebuild,v 1.1 2003/04/12 19:33:15 george Exp $

DESCRIPTION="Fortran to C converter"
HOMEPAGE="http://www.netlib.org/f2c"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="libf2c"
SLOT="0"
KEYWORDS="x86"

IUSE=""
DEPEND="dev-libs/libf2c"

S="${WORKDIR}/src"

src_compile() {
	sed -e "s:CFLAGS = -O::" \
		-e "s:CC = cc::" -i.orig makefile

	emake || die
}

src_install() {
	mv -f f2c.1t f2c.1
	doman f2c.1
	dobin f2c
	dodoc README Notice
}
