# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libfame/libfame-0.9.0.ebuild,v 1.8 2003/04/25 13:46:40 vapier Exp $

inherit flag-o-matic

S=${WORKDIR}/${P}
DESCRIPTION="MPEG-1 and MPEG-4 video encoding library"
SRC_URI="mirror://sourceforge/fame/${P}.tar.gz"
HOMEPAGE="http://fame.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc ~alpha"

DEPEND="virtual/glibc"

replace-flags "-fprefetch-loop-arrays" " "

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
    
	einstall install || die
	dobin libfame-config

	insinto /usr/share/aclocal
	doins libfame.m4

	dodoc CHANGES README
	doman doc/*.3
}
