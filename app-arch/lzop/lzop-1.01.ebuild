# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/lzop/lzop-1.01.ebuild,v 1.1 2003/09/12 03:34:17 vapier Exp $

DESCRIPTION="Utility for fast (even reat-time) compression/decompression"
HOMEPAGE="http://www.oberhumer.com/opensource/lzop/"
SRC_URI="http://www.oberhumer.com/opensource/lzop/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"

DEPEND="dev-libs/lzo"

src_compile() {
	econf --disable-shared || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog COPYING* NEWS README THANKS
	dodoc doc/lzop.{txt,ps}
	dohtml doc/*.html
}
