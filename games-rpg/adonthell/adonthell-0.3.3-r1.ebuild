# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/adonthell/adonthell-0.3.3-r1.ebuild,v 1.8 2004/12/06 23:22:20 mr_bones_ Exp $

inherit games

DESCRIPTION="roleplaying game engine"
HOMEPAGE="http://adonthell.linuxgames.com/"
SRC_URI="http://savannah.nongnu.org/download/adonthell/${PN}-src-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE="nls doc"

DEPEND="dev-lang/python
	media-libs/libsdl
	media-libs/libvorbis
	media-libs/libogg
	sys-libs/zlib
	doc? ( app-doc/doxygen )"

src_compile() {
	egamesconf \
		$(use_enable nls) \
		$(use_enable doc) \
		|| die
	touch doc/items/{footer,header}.html
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README AUTHORS ChangeLog FULLSCREEN.howto NEWBIE NEWS
	prepgamesdirs
}
