# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libextractor/libextractor-0.1.0.ebuild,v 1.7 2004/02/22 20:04:03 agriffis Exp $

IUSE="oggvorbis"

S=${WORKDIR}/extractor-${PV}
DESCRIPTION="A simple library for keyword extraction"
HOMEPAGE="http://www.ovmj.org/~samanta/libextractor"
SRC_URI="http://www.ovmj.org/~samanta/libextractor/download/extractor-${PV}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc"

DEPEND=">=sys-devel/libtool-1.4.1
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta4 )"

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
