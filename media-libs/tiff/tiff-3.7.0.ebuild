# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/tiff/tiff-3.7.0.ebuild,v 1.4 2004/11/22 23:37:25 kloeri Exp $

inherit eutils

DESCRIPTION="Library for manipulation of TIFF (Tag Image File Format) images."
HOMEPAGE="http://www.libtiff.org/"
SRC_URI="http://dl.maptools.org/dl/libtiff/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~mips alpha ~arm ~hppa ~amd64 ~ia64 ~s390 ~ppc-macos ~ppc64"
IUSE=""

DEPEND=">=media-libs/jpeg-6b
	>=sys-libs/zlib-1.1.3-r2"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	epatch ${FILESDIR}/${P}-sharedlibsnamefix.patch
	epatch ${FILESDIR}/${P}-tiff2ps_float.patch
}

src_compile() {
	econf --without-x || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc README TODO VERSION
}

