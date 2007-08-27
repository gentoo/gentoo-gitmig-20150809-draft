# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/bitefusion/bitefusion-1.0.1.ebuild,v 1.2 2007/08/27 23:47:11 tupone Exp $

inherit eutils games

DESCRIPTION="A snake game with 15 levels"
HOMEPAGE="http://www.junoplay.com"
SRC_URI="http://www.junoplay.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libsdl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	#just to avoid QA notice
	epatch "${FILESDIR}"/${P}-gentoo.patch
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	dodoc AUTHORS
	prepgamesdirs
}
