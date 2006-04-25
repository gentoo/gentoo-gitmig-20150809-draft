# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ace/ace-1.2-r1.ebuild,v 1.16 2006/04/25 21:18:45 tupone Exp $

inherit eutils games

DESCRIPTION="DJ Delorie's Ace of Penguins solitaire games"
HOMEPAGE="http://www.delorie.com/store/ace/"
SRC_URI="http://www.delorie.com/store/ace/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND="|| ( x11-libs/libXpm virtual/x11 )
	media-libs/libpng
	sys-libs/zlib"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}"-check_for_end_of_game.patch \
		"${FILESDIR}/${P}"-gcc41.patch

	# Fix timestamps so we dont run autotools #76473
	touch -r aclocal.m4 configure.in
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
	dohtml docs/*
	prepgamesdirs
}
