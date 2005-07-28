# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/recmpeg/recmpeg-1.0.5.ebuild,v 1.8 2005/07/28 11:06:10 dholm Exp $

DESCRIPTION="recmpeg is a simple video encoder, based on libfame, which compresses raw video sequences to MPEG video"
HOMEPAGE="http://fame.sourceforge.net/"
SRC_URI="mirror://sourceforge/fame/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="mmx sse"

DEPEND="virtual/libc
	>=media-libs/libfame-0.9.0"

src_compile() {
	local myconf

	use mmx && myconf="${myconf} --enable-mmx"
	use sse && myconf="${myconf} --enable-sse"

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall install || die "einstall died"
	dodoc CHANGES README INSTALL NEWS
}
