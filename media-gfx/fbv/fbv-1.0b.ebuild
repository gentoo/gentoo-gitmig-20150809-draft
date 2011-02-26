# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fbv/fbv-1.0b.ebuild,v 1.14 2011/02/26 17:08:40 signals Exp $

inherit toolchain-funcs eutils

DESCRIPTION="simple program to view pictures on a linux framebuffer device"
HOMEPAGE="http://freshmeat.net/projects/fbv/"
SRC_URI="http://s-tech.elsat.net.pl/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 arm ~ppc ppc64 sh x86"
IUSE="gif jpeg png"

DEPEND="gif? ( media-libs/giflib )
	jpeg? ( virtual/jpeg )
	png? ( media-libs/libpng )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/oob-segfault-fbv-${PV}.diff
	sed -e 's/-lungif/-lgif/g' -i Makefile -i configure
}

src_compile() {
	local myconf=""
	myconf="${myconf} --without-bmp"
	use png || myconf="${myconf} --without-libpng"
	use gif || myconf="${myconf} --without-libungif"
	use jpeg || myconf="${myconf} --without-libjpeg"
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		${myconf} || die "configure failed"
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin fbv || die "dobin failed"
	doman fbv.1
	dodoc ChangeLog README TODO VERSION
}
