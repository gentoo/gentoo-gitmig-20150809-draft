# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/fame/fame-0.9.0.ebuild,v 1.4 2003/07/12 21:12:38 aliz Exp $

IUSE="mmx sse"

DESCRIPTION="fame is a multimedia encoder, which captures video from a video4linux device, and optionnaly sound, for MPEG encoding."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://fame.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/glibc
	>=media-libs/libfame-0.9.0"

src_compile() {
	local myconf

	use mmx && myconf="${myconf} --enable-mmx"
	use sse && myconf="${myconf} --enable-sse"

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dodir /usr/lib
    
	einstall install || die "einstall failed"

	dodoc AUTHORS BUGS CHANGES README TODO
	doman doc/*.1
}
