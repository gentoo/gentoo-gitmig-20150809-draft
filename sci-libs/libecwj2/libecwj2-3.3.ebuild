# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libecwj2/libecwj2-3.3.ebuild,v 1.1 2006/12/19 15:27:16 djay Exp $

DESCRIPTION="This library offers read (decompress) and write (compress) for both the ECW and the ISO JPEG 2000 image file formats"
SRC_URI="${P}-2006-09-06.zip"
HOMEPAGE="http://www.ermapper.com/ecw/"
PKG_URL="http//www.ermapper.com/downloads/download_view.aspx?PRODUCT_VERSION_ID=305"

LICENSE="ECWPL"
RESTRICT="fetch"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc examples"

DEPEND="virtual/libc"

pkg_nofetch() {
	einfo "Download latest archive from :"
	einfo "${PKG_URL}"
	einfo "Then move it to ${DISTDIR}/${SRC_URI}"
}

src_install() {
	into /usr
	mkdir -p "${D}usr/include"	# hack to enable install of include files

	make DESTDIR=${D} install || die "make install failed"
	if use doc; then
		dodoc SDK.pdf
	fi
	if use examples; then
		dodir /usr/share/doc/${P}/
		cp -r ./examples/ "${D}"usr/share/doc/${P}/
	fi
}
