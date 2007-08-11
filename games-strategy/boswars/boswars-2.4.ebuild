# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/boswars/boswars-2.4.ebuild,v 1.1 2007/08/11 00:44:32 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="Futuristic real-time strategy game"
HOMEPAGE="http://www.boswars.org/"
SRC_URI="http://www.boswars.org/dist/releases/${P}-src.tar.gz
	mirror://gentoo/bos.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-lang/lua
	media-libs/libsdl
	media-libs/libpng
	media-libs/libvorbis
	media-libs/libtheora
	media-libs/libogg
	x11-libs/libX11"
DEPEND="${RDEPEND}
	dev-util/scons"

S=${WORKDIR}/${P}-src

src_unpack() {
	unpack ${A/bos.png}
	cd "${S}"
	rm doc/README-SDL.txt
	rm doc/guichan-copyright.txt
	epatch "${FILESDIR}"/${P}-gentoo.patch
	sed -i -e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		engine/include/stratagus.h || die "sed failed"
}

src_compile() {
	scons || die "scons failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	dodoc CHANGELOG COPYRIGHT.txt README.txt
	dohtml -r doc/*
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r campaigns graphics languages maps scripts sounds units video \
		|| die "doins failed"

	doicon "${DISTDIR}"/bos.png
	make_desktop_entry ${PN} "Bos Wars"	bos.png

	prepgamesdirs
}
