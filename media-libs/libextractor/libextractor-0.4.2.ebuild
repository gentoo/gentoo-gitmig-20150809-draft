# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libextractor/libextractor-0.4.2.ebuild,v 1.3 2006/01/16 23:06:11 mkay Exp $

inherit libtool

IUSE="vorbis static"
DESCRIPTION="A simple library for keyword extraction"
HOMEPAGE="http://www.ovmj.org/~samanta/libextractor"
SRC_URI="http://gnunet.org/libextractor/download/${P}.tar.bz2"
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
DEPEND="virtual/libc
	>=sys-devel/libtool-1.4.1
	vorbis? ( >=media-libs/libvorbis-1.0_beta4 )"

src_compile() {
	elibtoolize
	econf --with-gnu-ld \
		`use_enable static` || die "econf failed"
	make || die "compile failed"
}

src_install () {
	make DESTDIR=${D} install || die "install failed"
}
