# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/exiftags/exiftags-0.99.1.ebuild,v 1.1 2004/06/16 17:30:40 liquidx Exp $


DESCRIPTION="Extracts JPEG EXIF headers from digital camera photos"
HOMEPAGE="http://johnst.org/sw/exiftags/"
SRC_URI="http://johnst.org/sw/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""

src_compile() {
	make || die "make failed"
}

src_install() {
	dobin exiftags exifcom exiftime
	doman exiftags.1 exifcom.1 exiftime.1
	dodoc README CHANGES
}
