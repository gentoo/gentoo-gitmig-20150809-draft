# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gif2png/gif2png-2.5.1.ebuild,v 1.12 2006/03/20 02:33:58 vapier Exp $

DESCRIPTION="Converts images from gif format to png format"
HOMEPAGE="http://catb.org/~esr/gif2png/"
SRC_URI="http://catb.org/~esr/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~ppc-macos ppc64 sparc x86"
IUSE=""

DEPEND="media-libs/libpng"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
