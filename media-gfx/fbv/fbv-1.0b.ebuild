# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fbv/fbv-1.0b.ebuild,v 1.1 2005/01/03 22:22:28 dragonheart Exp $

inherit toolchain-funcs

DESCRIPTION="simple program to view pictures on a linux framebuffer device"
HOMEPAGE="http://s-tech.elsat.net.pl/fbv/"
SRC_URI="http://s-tech.elsat.net.pl/fbv//${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc64"
IUSE="png gif jpeg"

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
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		${myconf} || die "econf failed"

	emake CC="$(tc-getCC) ${CFLAGS}" || die
}

src_install() {
	dobin fbv || die
	doman fbv.1
	dodoc ChangeLog README TODO VERSION
}
