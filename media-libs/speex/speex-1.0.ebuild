# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Speex - Speech encoding library"
HOMEPAGE="http://www.speex.org"
SRC_URI="http://www.speex.org/download/${MY_P}.tar.gz"
SLOT="0"
LICENSE="BSD as-is"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="virtual/glibc"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	einstall || die
	rm -rf ${D}/usr/share/doc/*
	
	insinto /usr/share/doc/${P}
	doins ${S}/doc/manual.pdf
	dodoc AUTHORS ChangeLog README TODO NEWS
}
