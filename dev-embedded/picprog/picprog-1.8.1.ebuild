# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/picprog/picprog-1.8.1.ebuild,v 1.2 2006/12/03 00:31:26 beandog Exp $

inherit eutils

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
	cd ${S}
	epatch "${FILESDIR}"/${PN}-1.7-werner-almesberger.diff || die "epatch failed"
	epatch "${FILESDIR}"/${PN}-1.7-gcc41.patch || die "epatch failed"
}

src_compile() {
	emake CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	dobin picprog || die
	dodoc README
	dohtml picprog.html *.png
	doman picprog.1
}
