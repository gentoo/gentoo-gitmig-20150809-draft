# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/vcr/vcr-1.09.ebuild,v 1.2 2002/07/19 11:28:21 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="VCR - Linux Console VCR"
SRC_URI="http://www.stack.nl/~brama/${PN}/src/vcr-1.09.tar.gz"
HOMEPAGE="http://www.stack.nl/~brama/vcr/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=media-video/avifile-0.6"

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
