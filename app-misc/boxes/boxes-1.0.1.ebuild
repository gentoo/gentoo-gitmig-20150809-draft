# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/boxes/boxes-1.0.1.ebuild,v 1.22 2004/10/31 20:41:30 ciaranm Exp $

inherit eutils

DESCRIPTION="draw any kind of boxes around your text!"
HOMEPAGE="http://boxes.thomasjensen.com/"
SRC_URI="http://boxes.thomasjensen.com/download/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha ~amd64 ppc64"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}


src_compile() {
	make clean || die
	make CFLAGS="$CFLAGS -I. -Iregexp" || die
}

src_install() {
	dobin src/boxes || die
	doman doc/boxes.1
	dodoc README*
	insinto /usr/share/boxes
	doins boxes-config
}
