# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/jhead/jhead-1.9.ebuild,v 1.2 2003/04/18 03:35:55 vladimir Exp $

IUSE=""
S=${WORKDIR}/${P}
DESCRIPTION="a program for making thumbnails for websites."
SRC_URI="http://www.sentex.net/~mwandel/jhead/${P}.tar.gz"
HOMEPAGE="http://www.sentex.net/~mwandel/jhead/"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/glibc"

src_compile() {

	cd ${S}
	emake || die
}

src_install () {

	dobin jhead  
	dodoc readme.txt changes.txt
	dohtml usage.html
}
