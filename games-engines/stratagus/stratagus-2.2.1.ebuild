# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/stratagus/stratagus-2.2.1.ebuild,v 1.1 2007/01/12 03:12:18 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="A realtime strategy game engine"
HOMEPAGE="http://www.stratagus.org/"
SRC_URI="mirror://sourceforge/stratagus/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug doc mikmod mng opengl theora vorbis"

RDEPEND="app-arch/bzip2
	>=dev-lang/lua-5
	media-libs/libpng
	media-libs/libsdl
	sys-libs/zlib
	mikmod? ( media-libs/libmikmod )
	mng? ( media-libs/libmng )
	theora? ( media-libs/libtheora )
	vorbis? ( media-libs/libogg media-libs/libvorbis )"

DEPEND="${RDEPEND}
	x11-libs/libXt
	doc? ( app-doc/doxygen )"

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_with mikmod) \
		$(use_with flac) \
		$(use_with mp3 mad) \
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
