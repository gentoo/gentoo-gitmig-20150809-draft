# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/scummvm-tools/scummvm-tools-0.12.0.ebuild,v 1.4 2009/01/21 15:02:49 fmccor Exp $

WX_GTK_VER=2.8
inherit toolchain-funcs wxwidgets games

DESCRIPTION="utilities for the SCUMM game engine"
HOMEPAGE="http://scummvm.sourceforge.net/"
SRC_URI="mirror://sourceforge/scummvm/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="media-libs/libpng
	media-libs/flac
	media-libs/libvorbis
	=x11-libs/wxGTK-2.8*"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f *.bat
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CXX="$(tc-getCXX)" \
		CFLAGS="${CFLAGS} -DUNIX" \
		LDFLAGS="${LDFLAGS}" \
		|| die "emake failed"
}

src_install() {
	local f
	for f in $(find . -type f -perm +1 -print); do
		newgamesbin $f ${PN}-${f##*/} || die "newgamesbin $f failed"
	done
	dodoc README
	prepgamesdirs
}
