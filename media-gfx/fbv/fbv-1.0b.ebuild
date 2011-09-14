# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fbv/fbv-1.0b.ebuild,v 1.15 2011/09/14 11:31:48 ssuominen Exp $

EAPI=4
inherit eutils toolchain-funcs

DESCRIPTION="simple program to view pictures on a linux framebuffer device"
HOMEPAGE="http://freshmeat.net/projects/fbv/"
SRC_URI="http://s-tech.elsat.net.pl/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 arm ~ppc ppc64 sh x86"
IUSE="gif jpeg png"

RDEPEND="gif? ( media-libs/giflib )
	jpeg? ( virtual/jpeg )
	png? ( media-libs/libpng )"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch \
		"${FILESDIR}"/oob-segfault-fbv-${PV}.diff \
		"${FILESDIR}"/${P}-libpng15.patch

	sed -i -e 's:-lungif:-lgif:g' configure Makefile || die
}

src_configure() {
	local myconf="--without-bmp"

	use png || myconf="${myconf} --without-libpng"
	use gif || myconf="${myconf} --without-libungif"
	use jpeg || myconf="${myconf} --without-libjpeg"

	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		${myconf} || die
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}"
}

src_install() {
	dobin fbv
	doman fbv.1
	dodoc ChangeLog README TODO VERSION
}
