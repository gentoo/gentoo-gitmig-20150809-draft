# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/fame/fame-0.9.0.ebuild,v 1.11 2006/03/07 16:35:47 flameeyes Exp $

DESCRIPTION="fame is a multimedia encoder, which captures video from a video4linux device, and optionally sound, for MPEG encoding."
HOMEPAGE="http://fame.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="mmx sse"

DEPEND=">=media-libs/libfame-0.9.0"

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
