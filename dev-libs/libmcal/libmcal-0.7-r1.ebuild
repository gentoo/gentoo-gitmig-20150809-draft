# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmcal/libmcal-0.7-r1.ebuild,v 1.1 2003/07/24 11:23:54 gmsoft Exp $

DESCRIPTION="Modular Calendar Access Libary"
HOMEPAGE="http://mcal.chek.com/"
SRC_URI="mirror://sourceforge/libmcal/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~ppc ~sparc ~alpha hppa ~mips"

IUSE=""
DEPEND=""
RDEPEND=""
S=${WORKDIR}/${PN}

src_compile() {
	econf

	[ "${ARCH}" = "hppa" ] && CFLAGS="${CFLAGS} -fPIC"

	cd ${S}
	cp Makefile Makefile.orig
	sed -e "s/-O0 -Wall -g/-Wall ${CFLAGS}/" Makefile.orig > Makefile

	emake || die
}

src_install() {
	einstall DESTDIR=${D} || die
	dodoc CHANGELOG FAQ-MCAL FEATURE-IMPLEMENTATION HOW-TO-MCAL LICENSE README
	dohtml FUNCTION-REF.html
}
