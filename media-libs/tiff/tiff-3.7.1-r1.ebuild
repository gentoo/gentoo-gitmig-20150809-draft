# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/tiff/tiff-3.7.1-r1.ebuild,v 1.9 2005/01/05 02:11:53 j4rg0n Exp $

inherit eutils

DESCRIPTION="Library for manipulation of TIFF (Tag Image File Format) images."
HOMEPAGE="http://www.libtiff.org/"
SRC_URI="http://dl.maptools.org/dl/libtiff/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha ~arm ~hppa amd64 ~ia64 ~s390 ppc-macos ppc64"
IUSE=""

DEPEND=">=media-libs/jpeg-6b
	>=sys-libs/zlib-1.1.3-r2"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	epatch ${FILESDIR}/${P}-trans.patch || die "transparency patch failed"
	epatch ${FILESDIR}/${P}-tiffdump.patch || die "tiffdump patch failed"
}

src_compile() {
	econf --without-x || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc README TODO VERSION
}

pkg_postinst() {
	einfo "Latest tiff with bug #75423 and #75316 fixes."
}
