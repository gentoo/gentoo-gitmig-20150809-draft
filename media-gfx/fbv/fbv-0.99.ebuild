# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fbv/fbv-0.99.ebuild,v 1.1 2003/08/25 13:43:46 usata Exp $

IUSE="png gif jpeg"

DESCRIPTION="fbv is a simple program to view pictures on a linux framebuffer device"
HOMEPAGE="http://s-tech.elsat.net.pl/fbv/"
SRC_URI="http://s-tech.elsat.net.pl/fbv//${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="gif? ( media-libs/libungif )
	jpeg? ( media-libs/jpeg )
	png? ( media-libs/libpng )"

src_compile() {

	local myconf

	use png || myconf="${myconf} --without-libpng"
	use gif || myconf="${myconf} --without-libungif"
	use jpeg || myconf="${myconf} --without-libjpeg"

	./configure \
		--prefix=/usr \
		--bindir=/usr/bin \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} || die
	emake CC="${CC} ${CFLAGS}" || die
}

src_install() {

	dobin fbv
	doman fbv.1

	dodoc ChangeLog README TODO VERSION
}
