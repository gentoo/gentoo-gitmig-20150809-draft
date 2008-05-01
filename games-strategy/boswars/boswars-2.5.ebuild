# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/boswars/boswars-2.5.ebuild,v 1.2 2008/05/01 00:21:34 nyhm Exp $

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
	virtual/opengl
	x11-libs/libX11"
DEPEND="${RDEPEND}
	dev-util/scons"

S=${WORKDIR}/${P}-src

src_unpack() {
	unpack ${A/bos.png}
	cd "${S}"
	rm -f doc/{README-SDL.txt,guichan-copyright.txt}
	epatch \
		"${FILESDIR}"/${P}-gentoo.patch \
		"${FILESDIR}"/${P}-gcc43.patch
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		engine/include/stratagus.h \
		|| die "sed stratagus.h failed"
	sed -i \
		-e "/-O2/s:-O2.*math:${CXXFLAGS} -Wall:" \
		SConstruct \
		|| die "sed SConstruct failed"
}

src_compile() {
	scons || die "scons failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r campaigns graphics intro languages maps scripts sounds units \
		|| die "doins failed"
	doicon "${DISTDIR}"/bos.png
	make_desktop_entry ${PN} "Bos Wars"	bos
	dodoc CHANGELOG COPYRIGHT.txt README.txt
	dohtml -r doc/*
	prepgamesdirs
}
