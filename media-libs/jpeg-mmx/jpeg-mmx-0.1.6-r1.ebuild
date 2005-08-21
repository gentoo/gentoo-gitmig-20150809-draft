# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jpeg-mmx/jpeg-mmx-0.1.6-r1.ebuild,v 1.2 2005/08/21 18:09:24 vapier Exp $

inherit eutils

DESCRIPTION="JPEG library with mmx enhancements"
HOMEPAGE="http://mjpeg.sourceforge.net/"
SRC_URI="mirror://sourceforge/mjpeg/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

DEPEND="dev-lang/nasm"
RDEPEND=""

S=${WORKDIR}/jpeg-mmx

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-PIC.patch
	epatch "${FILESDIR}"/${P}-makefile.patch
}

src_compile() {
	econf \
		--includedir=/usr/include/jpeg-mmx \
		--enable-shared \
		--enable-static \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	dodir /usr/include/jpeg-mmx
	make install-headers includedir="${D}"/usr/include/jpeg-mmx || die "headers"

	for x in cjpeg djpeg jpegtran ; do
		newbin .libs/${x} ${x}-mmx || die "dobin ${x}"
	done

	dolib.a .libs/libjpeg-mmx.a || die "dolib.a"
	cp -a .libs/libjpeg-mmx.so* libjpeg-mmx.la "${D}"/usr/lib/ || die "dolib.so"

	dodoc README change.log structure.doc libjpeg.doc
}
