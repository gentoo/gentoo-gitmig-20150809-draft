# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/libfame/libfame-0.8.10.ebuild,v 1.3 2002/08/14 13:08:09 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="libfame is a video encoding library. (MPEG-1 and MPEG-4)"
SRC_URI="mirror://sourceforge/fame/${P}.tar.gz"
HOMEPAGE="http://fame.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/glibc"

src_compile() {
	local myconf

	use mmx && myconf="${myconf} --enable-mmx"
	use sse && myconf="${myconf} --enable-sse"

	econf ${myconf} || die
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
