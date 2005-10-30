# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/jpegpixi/jpegpixi-1.0.3.ebuild,v 1.2 2005/10/30 15:58:53 grobian Exp $

DESCRIPTION="almost lossless JPEG pixel interpolator, for correcting digital camera defects."
HOMEPAGE="http://www.zero-based.org/software/jpegpixi/"
SRC_URI="http://www.zero-based.org/software/jpegpixi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~x86"
IUSE=""

DEPEND="media-libs/jpeg"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	insinto /usr/bin
	dobin jpegpixi jpeghotp

	doman man/jpegpixi.1 man/jpeghotp.1

	dodoc AUTHORS NEWS README README.jpeglib ChangeLog
}
