# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/jhead/jhead-2.0.ebuild,v 1.5 2003/12/08 04:49:15 rajiv Exp $

IUSE=""
S=${WORKDIR}/${P}
DESCRIPTION="Exif Jpeg camera setting parser and thumbnail remover"
SRC_URI="http://www.sentex.net/~mwandel/jhead/${P}.tar.gz"
HOMEPAGE="http://www.sentex.net/~mwandel/jhead/"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="x86 sparc ~ppc"

DEPEND="virtual/glibc"

src_compile() {

	cd ${S}
	emake || die
}

src_install () {

	dobin jhead
	dodoc readme.txt changes.txt
	dohtml usage.html
	doman jhead.1.gz
}
