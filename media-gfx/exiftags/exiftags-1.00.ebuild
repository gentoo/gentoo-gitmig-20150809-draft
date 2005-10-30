# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/exiftags/exiftags-1.00.ebuild,v 1.2 2005/10/30 16:09:40 grobian Exp $

DESCRIPTION="Extracts JPEG EXIF headers from digital camera photos"
HOMEPAGE="http://johnst.org/sw/exiftags/"
SRC_URI="http://johnst.org/sw/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~x86"
IUSE=""

DEPEND=""

src_compile() {
	make || die "make failed"
}

src_install() {
	dobin exiftags exifcom exiftime || die
	doman exiftags.1 exifcom.1 exiftime.1
	dodoc README CHANGES
}
