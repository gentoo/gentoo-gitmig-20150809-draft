# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fbi/fbi-1.25.ebuild,v 1.12 2004/06/24 22:36:36 agriffis Exp $

DESCRIPTION="fbi a framebuffer image viewer"
HOMEPAGE="http://bytesex.org/fbi.html"
SRC_URI="http://bytesex.org/misc/${P/-/_}.tar.gz"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha hppa"

DEPEND=">=media-libs/jpeg-6b"

src_compile() {
	export CFLAGS="${CFLAGS}"
	make CC=gcc || die
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		install || die

	dodoc COPYING README
}
