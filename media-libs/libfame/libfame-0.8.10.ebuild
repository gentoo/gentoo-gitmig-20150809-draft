# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/libfame/libfame-0.8.10.ebuild,v 1.1 2002/07/19 03:39:01 chadh Exp $

#A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libfame is a video encoding library. (MPEG-1 and MPEG-4)"
SRC_URI="mirror://sourceforge/fame/${P}.tar.gz"
HOMEPAGE="http://fame.sourceforge.net"
LICENSE="GPL-2" # The web page says LGPL too, but no license in the tar ball
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc"

RDEPEND="virtual/glibc"

src_compile() {
	local myconf

	use mmx && myconf="--enable-mmx"
	use sse && myconf="${myconf} --enable-sse"

	./configure --prefix=/usr --host=${CHOST} ${myconf} || die
	emake || die
}

src_install() {
	dodir /usr
	dodir /usr/lib
    
	make prefix=${D}/usr install || die
	dobin libfame-config

	insinto /usr/share/aclocal
	doins libfame.m4

	dodoc CHANGES README
	doman doc/*.3
}
