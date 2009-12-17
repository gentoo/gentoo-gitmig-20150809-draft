# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/scummvm-tools/scummvm-tools-1.0.0.ebuild,v 1.2 2009/12/17 21:27:25 pacho Exp $

EAPI=2
WX_GTK_VER=2.8
inherit toolchain-funcs wxwidgets games

DESCRIPTION="utilities for the SCUMM game engine"
HOMEPAGE="http://scummvm.sourceforge.net/"
SRC_URI="mirror://sourceforge/scummvm/${P/_/}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="media-libs/libpng
	media-libs/flac
	media-libs/libvorbis
	x11-libs/wxGTK:2.8"

S=${WORKDIR}/${P/_/}

src_prepare() {
	rm -f *.bat
	sed -ri \
		-e '/^(CC|CXX)\b/d' \
		Makefile \
		|| die "sed failed"
}

src_install() {
	local f
	for f in $(find . -type f -perm +1 -print); do
		newgamesbin $f ${PN}-${f##*/} || die "newgamesbin $f failed"
	done
	dodoc README TODO
	prepgamesdirs
}
