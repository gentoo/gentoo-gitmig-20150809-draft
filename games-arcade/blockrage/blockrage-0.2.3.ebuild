# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/blockrage/blockrage-0.2.3.ebuild,v 1.1 2007/02/06 23:48:12 tupone Exp $

inherit eutils games

DESCRIPTION="Falling-blocks arcade game with a 2-player hotseat mode"
HOMEPAGE="http://blockrage.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-libs/libsdl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Removing error due to wrong detection of cross-compile mode
	epatch "${FILESDIR}/${P}"-config.patch
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ChangeLog KNOWN_BUGS README TODO
	prepgamesdirs
}
