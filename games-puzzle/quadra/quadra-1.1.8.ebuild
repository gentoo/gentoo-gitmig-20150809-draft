# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/quadra/quadra-1.1.8.ebuild,v 1.1 2003/09/10 06:36:00 vapier Exp $

inherit gcc

DESCRIPTION="A tetris clone with multiplayer support"
SRC_URI="mirror://sourceforge/quadra/${P}.tar.gz"
HOMEPAGE="http://quadra.sourceforge.net/"

KEYWORDS="x86"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="svga"

DEPEND=">=x11-base/xfree-4.1.0
	>=media-libs/libpng-1.2.1
	sys-libs/zlib
	svga? ( media-libs/svgalib )"

src_compile() {
	[ `gcc-major-version` == 3 ] && patch -p1<${FILESDIR}/${P}-gcc3.patch
	patch -p0<${FILESDIR}/libpng-1.2.5.patch

	local myconf
	use svga \
		&& myconf="--with-svgalib" \
		|| myconf="--without-svgalib"

	econf ${myconf}
	emake || die "emake failed"
}

src_install() {
	einstall

	dodoc ChangeLog NEWS README
	dohtml help/*
}
