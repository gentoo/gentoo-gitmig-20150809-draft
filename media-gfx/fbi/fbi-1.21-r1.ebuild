# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fbi/fbi-1.21-r1.ebuild,v 1.7 2004/03/29 00:56:49 vapier Exp $

DESCRIPTION="fbi a framebuffer image viewer"
HOMEPAGE="http://www.strusel007.de/linux/fbi.html"
SRC_URI="http://www.strusel007.de/linux/misc/${P/-/_}.tar.gz"

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
