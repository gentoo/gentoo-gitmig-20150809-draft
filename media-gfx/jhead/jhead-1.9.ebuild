# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/jhead/jhead-1.9.ebuild,v 1.7 2004/07/14 17:45:40 agriffis Exp $

IUSE=""
DESCRIPTION="a program for making thumbnails for websites."
SRC_URI="http://www.sentex.net/~mwandel/jhead/${P}.tar.gz"
HOMEPAGE="http://www.sentex.net/~mwandel/jhead/"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="x86 ~ppc"

DEPEND="virtual/libc"

src_compile() {

	cd ${S}
	emake || die
}

src_install () {

	dobin jhead
	dodoc readme.txt changes.txt
	dohtml usage.html
}
