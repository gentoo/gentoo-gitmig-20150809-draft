# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/exiftags/exiftags-1.01.ebuild,v 1.1 2007/12/16 14:14:20 maekke Exp $

DESCRIPTION="Extracts JPEG EXIF headers from digital camera photos"
HOMEPAGE="http://johnst.org/sw/exiftags/"
SRC_URI="http://johnst.org/sw/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~x86"
IUSE=""

DEPEND=""

src_install() {
	dobin exiftags exifcom exiftime || die
	doman exiftags.1 exifcom.1 exiftime.1
	dodoc README CHANGES
}
