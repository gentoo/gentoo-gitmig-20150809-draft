# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ace/ace-1.2-r1.ebuild,v 1.11 2005/01/03 03:16:38 vapier Exp $

inherit games eutils

DESCRIPTION="DJ Delorie's Ace of Penguins solitaire games"
HOMEPAGE="http://www.delorie.com/store/ace/"
SRC_URI="http://www.delorie.com/store/ace/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc sparc x86"
IUSE=""

RDEPEND="virtual/x11
	media-libs/libpng
	sys-libs/zlib"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/ace-1.2-check_for_end_of_game.patch

	# Fix timestamps so we dont run autotools #76473
	touch -r aclocal.m4 configure.in
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README
	dohtml docs/*
	prepgamesdirs
}
