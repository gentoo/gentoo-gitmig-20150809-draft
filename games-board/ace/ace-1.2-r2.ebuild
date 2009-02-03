# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ace/ace-1.2-r2.ebuild,v 1.2 2009/02/03 08:27:18 tupone Exp $

EAPI=2
inherit eutils games

DESCRIPTION="DJ Delorie's Ace of Penguins solitaire games"
HOMEPAGE="http://www.delorie.com/store/ace/"
SRC_URI="http://www.delorie.com/store/ace/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND="x11-libs/libXpm
	media-libs/libpng
	!games-misc/bsd-games"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-as-needed.patch \
		"${FILESDIR}"/${P}-check_for_end_of_game.patch \
		"${FILESDIR}"/${P}-gcc41.patch \
		"${FILESDIR}"/${P}-mastermind-keys.patch

	# Fix timestamps so we dont run autotools #76473
	touch -r aclocal.m4 configure.in
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
	dohtml docs/*
	prepgamesdirs
}
