# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/jhead/jhead-2.0.ebuild,v 1.7 2004/02/05 03:56:58 vapier Exp $

DESCRIPTION="Exif Jpeg camera setting parser and thumbnail remover"
HOMEPAGE="http://www.sentex.net/~mwandel/jhead/"
SRC_URI="http://www.sentex.net/~mwandel/jhead/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ppc sparc ~amd64"

DEPEND="virtual/glibc"

src_compile() {
	emake || die
}

src_install() {
	dobin jhead || die
	dodoc readme.txt changes.txt
	dohtml usage.html
	doman jhead.1.gz
}
