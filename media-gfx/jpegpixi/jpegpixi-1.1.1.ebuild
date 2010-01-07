# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/jpegpixi/jpegpixi-1.1.1.ebuild,v 1.6 2010/01/07 22:15:54 fauli Exp $

DESCRIPTION="almost lossless JPEG pixel interpolator, for correcting digital camera defects."
HOMEPAGE="http://www.zero-based.org/software/jpegpixi/"
SRC_URI="http://www.zero-based.org/software/jpegpixi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND="media-libs/jpeg"
DEPEND="${RDEPEND}"

src_install() {
	dobin jpegpixi jpeghotp || die
	doman man/jpegpixi.1 man/jpeghotp.1
	dodoc AUTHORS NEWS README README.jpeglib ChangeLog
}
