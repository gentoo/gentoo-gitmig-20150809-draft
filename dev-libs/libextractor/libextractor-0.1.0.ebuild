# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libextractor/libextractor-0.1.0.ebuild,v 1.5 2002/12/09 04:21:03 manson Exp $

IUSE="oggvorbis"

S=${WORKDIR}/extractor-${PV}
DESCRIPTION="A simple library for keyword extraction"
HOMEPAGE="http://www.ovmj.org/~samanta/libextractor"
SRC_URI="http://www.ovmj.org/~samanta/libextractor/download/extractor-${PV}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc "

DEPEND=">=sys-devel/libtool-1.4.1
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta4 )"

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
