# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/jpegpixi/jpegpixi-1.0.3.ebuild,v 1.1 2004/10/29 11:11:16 eldad Exp $

DESCRIPTION="almost lossless JPEG pixel interpolator, for correcting digital camera defects."
HOMEPAGE="http://www.zero-based.org/software/jpegpixi/"
SRC_URI="http://www.zero-based.org/software/jpegpixi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
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
