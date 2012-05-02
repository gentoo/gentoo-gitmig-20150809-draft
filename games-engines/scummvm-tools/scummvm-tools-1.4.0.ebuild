# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/scummvm-tools/scummvm-tools-1.4.0.ebuild,v 1.5 2012/05/02 21:02:01 jdhore Exp $

EAPI=2
WX_GTK_VER=2.8
inherit wxwidgets games

DESCRIPTION="utilities for the SCUMM game engine"
HOMEPAGE="http://scummvm.sourceforge.net/"
SRC_URI="mirror://sourceforge/scummvm/${P/_/}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~x86-fbsd"
IUSE="flac iconv mad png vorbis"
RESTRICT="test" # some tests require external files

RDEPEND="png? ( media-libs/libpng )
	mad? ( media-libs/libmad )
	flac? ( media-libs/flac )
	vorbis? ( media-libs/libvorbis )
	iconv? ( virtual/libiconv media-libs/freetype:2 )
	sys-libs/zlib
	x11-libs/wxGTK:2.8"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${P/_/}

src_prepare() {
	rm -rf *.bat dists/win32
	# use $T instead of /tmp - bug #402459
	sed -i \
		-e 's:/tmp:"${T}":' \
		configure || die
	sed -ri \
		-e '/^(CC|CXX)\b/d' \
		Makefile || die
}

src_configure() {
	# Not an autoconf script
	./configure \
		--enable-verbose-build \
		--mandir=/usr/share/man \
		--prefix=/usr/games \
		--libdir=/usr/games/lib \
		$(use_enable flac) \
		$(use_enable iconv) \
		$(use_enable iconv freetype) \
		$(use_enable mad) \
		$(use_enable png) \
		$(use_enable vorbis) \
		|| die
}

src_install() {
	local f
	for f in $(find . -type f -perm +1 -print); do
		newgamesbin $f ${PN}-${f##*/} || die "newgamesbin $f failed"
	done
	dodoc README TODO
	prepgamesdirs
}
