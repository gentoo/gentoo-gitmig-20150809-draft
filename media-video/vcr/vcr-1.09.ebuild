# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

DESCRIPTION="VCR - Linux Console VCR"
SRC_URI="http://www.stack.nl/~brama/${PN}/src/vcr-1.09.tar.gz"
HOMEPAGE="http://www.stack.nl/~brama/vcr/"
KEYWORDS="x86"
LICENSE="GPL-2"

DEPEND=">=media-video/avifile-0.6"
SLOT="0"

src_unpack () {
	   unpack ${P}.tar.gz
	   cd ${S}
	   patch -p0 ${S}/src/main.cc < ${FILESDIR}/${P}-avifile-0.7x.patch || die
}

src_compile () {
	    local myconf
	    myconf="--enable-avifile-0_6"
	    econf ${myconf} || die "econf died"
	    emake || die "emake died"
}

src_install () {

	einstall || die "einstall died"
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
