# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/quadra/quadra-1.1.8.ebuild,v 1.2 2004/01/14 05:22:49 vapier Exp $

inherit games eutils gcc

DESCRIPTION="A tetris clone with multiplayer support"
HOMEPAGE="http://quadra.sourceforge.net/"
SRC_URI="mirror://sourceforge/quadra/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
IUSE="svga"

DEPEND=">=x11-base/xfree-4.1.0
	>=media-libs/libpng-1.2.1
	sys-libs/zlib
	svga? ( media-libs/svgalib )"

src_unpack() {
	unpack ${A}
	cd ${S}
	[ `gcc-major-version` == 3 ] && epatch ${FILESDIR}/${P}-gcc3.patch
	epatch ${FILESDIR}/libpng-1.2.5.patch
	epatch ${FILESDIR}/${PV}-gcc.patch
	sed -i 's:-pedantic::' config/vars.mk
	sed -i \
		-e "/^libgamesdir:=/s:/games:/${PN}:" \
		-e "/^datagamesdir:=/s:/games:/${PN}:" \
		config/config.mk.in
}

src_compile() {
	egamesconf `use_with svgalib` || die
	emake || die "emake failed"
}

src_install() {
	egamesinstall || die
	dodir /usr/share/pixmaps
	mv ${D}/${GAMES_DATADIR}/pixmaps/quadra.xpm ${D}/usr/share/pixmaps
	rm -rf ${D}/usr/share/games/pixmaps

	dodoc ChangeLog NEWS README
	dohtml help/*
	prepgamesdirs
}
