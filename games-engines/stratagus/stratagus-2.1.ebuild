# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/stratagus/stratagus-2.1.ebuild,v 1.4 2004/11/12 20:40:21 blubb Exp $

inherit games

MY_PV=040702
DESCRIPTION="A realtime strategy game engine"
HOMEPAGE="http://www.stratagus.org/"
SRC_URI="mirror://sourceforge/stratagus/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug doc flac mad mikmod oggvorbis opengl"

RDEPEND="virtual/libc
	virtual/x11
	app-arch/bzip2
	dev-lang/lua
	media-libs/libpng
	media-libs/libsdl
	sys-devel/gcc
	sys-libs/zlib
	flac? ( media-libs/flac )
	mad? ( media-libs/libmad )
	mikmod? ( media-libs/libmikmod )
	oggvorbis? (
		media-libs/libogg
		media-libs/libvorbis
	)"

S="${WORKDIR}/stratagus-${MY_PV}"

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_with oggvorbis ogg) \
		$(use_with mikmod) \
		$(use_with flac) \
		$(use_with mad) \
		$(use_with opengl) \
		|| die "econf failed"
	emake -j1 || die "emake failed"

	if use doc ; then
		emake doc || die "making source documentation failed"
	fi
}

src_install() {
	dogamesbin stratagus || die "dogamesbin failed"
	dodoc README
	dohtml -r doc/*
	prepgamesdirs
}
