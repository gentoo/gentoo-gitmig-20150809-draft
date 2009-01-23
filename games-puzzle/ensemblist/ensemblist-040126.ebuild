# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/ensemblist/ensemblist-040126.ebuild,v 1.7 2009/01/23 08:32:19 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Put together several primitives to build a given shape. (C.S.G. Game)"
HOMEPAGE="http://www.nongnu.org/ensemblist/index_en.html"
SRC_URI="http://savannah.nongnu.org/download/ensemblist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND="x11-libs/libXmu
	virtual/opengl
	virtual/glut
	virtual/glu
	media-libs/libpng
	media-libs/libmikmod[oss]"

PATCHES=( "${FILESDIR}"/${P}-build.patch )

src_compile() {
	emake DATADIR="\"${GAMES_DATADIR}\"/${PN}/datas" || die "emake failed"
}

src_install() {
	dogamesbin ensemblist || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r datas || die "doins failed"
	dodoc README Changelog
	make_desktop_entry ${PN} Ensemblist
	prepgamesdirs
}
