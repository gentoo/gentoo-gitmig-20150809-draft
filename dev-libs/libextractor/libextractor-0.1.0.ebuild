# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libextractor/libextractor-0.1.0.ebuild,v 1.1 2002/07/10 18:32:24 rphillips Exp $

DESCRIPTION="A simple library for keyword extraction"
HOMEPAGE="http://www.ovmj.org/~samanta/libextractor"
LICENSE="LGPL-2.1"
DEPEND=">=sys-devel/libtool-1.4.1
		oggvorbis? ( >=media-libs/libvorbis-1.0_beta4 >=media-libs/libogg-1.0_beta4 )"
RDEPEND="${DEPEND}"
SRC_URI="http://www.ovmj.org/~samanta/libextractor/download/extractor-${PV}.tar.gz"
S=${WORKDIR}/extractor-${PV}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
