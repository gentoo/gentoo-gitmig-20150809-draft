# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/stratagus/stratagus-2.2.4.ebuild,v 1.2 2008/12/17 15:41:37 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="A realtime strategy game engine"
HOMEPAGE="http://www.stratagus.org/"
SRC_URI="mirror://sourceforge/stratagus/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="bzip2 debug doc mikmod mng opengl theora vorbis"

RDEPEND="x11-libs/libX11
	>=dev-lang/lua-5
	media-libs/libpng
	media-libs/libsdl
	mikmod? ( media-libs/libmikmod )
	mng? ( media-libs/libmng )
	opengl? ( virtual/opengl )
	theora? ( media-libs/libtheora )
	vorbis? ( media-libs/libvorbis )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/SDLCONFIG --libs/s:"$: -lX11":' \
		-e 's/-O.*\(-fsigned-char\).*/\1"/' \
		configure \
		|| die "sed failed"
	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_with bzip2) \
		$(use_with mikmod) \
		$(use_with mng) \
		$(use_with opengl) \
		$(use_with theora) \
		$(use_with vorbis) \
		|| die
	emake -j1 || die "emake failed"

	if use doc ; then
		emake doc || die "emake doc failed"
	fi
}

src_install() {
	dogamesbin stratagus || die "dogamesbin failed"
	dodoc README
	dohtml -r doc/*
	use doc && dohtml -r srcdoc/html/*
	prepgamesdirs
}
