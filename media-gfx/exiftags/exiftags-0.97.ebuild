# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/exiftags/exiftags-0.97.ebuild,v 1.2 2003/07/12 16:44:48 aliz Exp $

IUSE=""

DESCRIPTION="Extracts JPEG EXIF headers from digital camera photos"
HOMEPAGE="http://johnst.org/sw/exiftags/"
SRC_URI="http://johnst.org/sw/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"

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
