# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libextractor/libextractor-0.5.0.ebuild,v 1.4 2005/12/26 12:22:25 lu_zero Exp $

inherit libtool eutils

IUSE="vorbis static"
DESCRIPTION="A simple library for keyword extraction"
HOMEPAGE="http://www.ovmj.org/~samanta/libextractor"
SRC_URI="http://gnunet.org/libextractor/download/${P}.tar.bz2"
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~sparc ~amd64 ~ppc"
# Disabled tests because they dont work (tester@g.o)
RESTRICT=test
DEPEND="virtual/libc
	>=sys-devel/libtool-1.4.1
	vorbis? ( >=media-libs/libvorbis-1.0_beta4 )"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-autotools.patch
}

src_compile() {
	elibtoolize
	econf --with-gnu-ld \
		`use_enable static` || die "econf failed"
	make || die "compile failed"
}

src_install () {
	make DESTDIR=${D} install || die "install failed"
}
