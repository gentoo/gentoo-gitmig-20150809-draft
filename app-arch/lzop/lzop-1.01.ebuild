# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/lzop/lzop-1.01.ebuild,v 1.11 2005/11/13 05:43:05 dragonheart Exp $

DESCRIPTION="Utility for fast (even real-time) compression/decompression"
HOMEPAGE="http://www.oberhumer.com/opensource/lzop/"
SRC_URI="http://www.oberhumer.com/opensource/lzop/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="<dev-libs/lzo-2"

src_compile() {
	econf --disable-shared || die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README THANKS
	dodoc doc/lzop.{txt,ps}
	dohtml doc/*.html
}
