# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/exiftags/exiftags-0.97.ebuild,v 1.4 2004/03/30 12:10:19 aliz Exp $

IUSE=""

DESCRIPTION="Extracts JPEG EXIF headers from digital camera photos"
HOMEPAGE="http://johnst.org/sw/exiftags/"
SRC_URI="http://johnst.org/sw/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~amd64"

DEPEND="virtual/glibc"

S=${WORKDIR}/${P}

src_compile() {
	make || die "make failed"
}

src_install() {
	dobin exiftags exifcom
	doman exiftags.1 exifcom.1
	dodoc README CHANGES
}
