# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/lzop/lzop-1.00.ebuild,v 1.13 2002/11/30 02:16:49 vapier Exp $

DESCRIPTION="Utility for fast (even reat-time) compression/decompression"
SRC_URI="http://www.oberhumer.com/opensource/lzop/download/${P}.tar.gz"
HOMEPAGE="http://www.oberhumer.com/opensource/lzop/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="dev-libs/lzo"

src_compile() {
	econf --disable-shared
	emake || die
}

src_install() {
	einstall
	dodoc AUTHORS ChangeLog COPYING* NEWS README THANKS
	dodoc doc/lzop.{txt,ps}
	dohtml doc/*.html
}
