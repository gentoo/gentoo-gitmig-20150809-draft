# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/zgv/zgv-5.9.ebuild,v 1.4 2011/02/28 17:49:08 ssuominen Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A svgalib console image viewer"
HOMEPAGE="http://www.svgalib.org/rus/zgv/"
SRC_URI="http://www.svgalib.org/rus/zgv/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=media-libs/svgalib-1.4.2
	virtual/jpeg
	media-libs/libpng
	>=media-libs/tiff-3.5.5
	>=sys-libs/zlib-1.1.4
	sys-apps/gawk"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i "/^CFLAGS=/s:=.*:=${CFLAGS}:" config.mk
	sed -i -e 's:$(RM):echo:' doc/Makefile
	epatch "${FILESDIR}"/${P}-Makefile-QA.patch
	epatch "${FILESDIR}"/zgv-5.9-cmyk-yccl-fix.diff
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	dodir /usr/bin /usr/share/info /usr/share/man/man1
	make PREFIX="${D}"/usr \
		INFODIR="${D}"/usr/share/info \
		MANDIR="${D}"/usr/share/man/man1 \
		install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README* SECURITY TODO

	# Fix info files
	cd "${D}"/usr/share/info
	rm dir*
	mv zgv zgv.info
	for i in 1 2 3 4 ; do
		mv zgv-$i zgv.info-$i
	done
}
