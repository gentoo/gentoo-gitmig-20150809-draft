# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/snake3d/snake3d-0.9.ebuild,v 1.1 2007/03/31 09:36:23 tupone Exp $

inherit eutils games

DESCRIPTION="variant of the snake game"
HOMEPAGE="http://sourceforge.net/projects/worms3d/"
SRC_URI="mirror://sourceforge/worms3d/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-libs/sdl-net
	virtual/opengl
	virtual/glut
	virtual/glu
	media-libs/libsdl"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}"-amd64.patch
}

src_install() {
	dodoc ChangeLog README TODO || die "failed installing doc"
	dogamesbin ${PN} || die "failed installing executable"
	prepgamesdirs
}
