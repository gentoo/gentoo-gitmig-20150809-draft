# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/jhead/jhead-2.2.ebuild,v 1.2 2004/11/02 19:46:18 corsair Exp $

DESCRIPTION="Exif Jpeg camera setting parser and thumbnail remover"
HOMEPAGE="http://www.sentex.net/~mwandel/jhead/"
SRC_URI="http://www.sentex.net/~mwandel/jhead/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~alpha ~ia64 ~hppa ~ppc64"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A} ; cd ${S}

	sed -i "s:-O3 -Wall:${CFLAGS}:" makefile
}

src_compile() {
	emake || die
}

src_install() {
	dobin jhead || die
	dodoc readme.txt changes.txt
	dohtml usage.html
	doman jhead.1.gz
}
