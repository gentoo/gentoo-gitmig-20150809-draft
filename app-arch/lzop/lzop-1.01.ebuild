# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/lzop/lzop-1.01.ebuild,v 1.7 2004/11/15 20:16:25 corsair Exp $

DESCRIPTION="Utility for fast (even real-time) compression/decompression"
HOMEPAGE="http://www.oberhumer.com/opensource/lzop/"
SRC_URI="http://www.oberhumer.com/opensource/lzop/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64 ~ppc64"
IUSE=""

DEPEND="dev-libs/lzo"

src_compile() {
	econf --disable-shared || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS README THANKS
	dodoc doc/lzop.{txt,ps}
	dohtml doc/*.html
}
