# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/adonthell/adonthell-0.3.3-r1.ebuild,v 1.2 2004/02/11 15:06:02 dholm Exp $

inherit games eutils

DESCRIPTION="roleplaying game engine"
HOMEPAGE="http://adonthell.linuxgames.com/"
SRC_URI="http://savannah.nongnu.org/download/adonthell/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="oggvorbis gtk nls doc"

DEPEND="dev-lang/python
	media-libs/libsdl
	oggvorbis? ( media-libs/libvorbis
		media-libs/libogg )
	sys-libs/zlib
	gtk? ( =x11-libs/gtk+-1* )
	doc? ( app-doc/doxygen )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-configure.in.patch
	autoconf || die
}

src_compile() {
	egamesconf \
		`use_enable nls` \
		`use_enable doc` \
		--with-gnu-ld \
		|| die
	touch doc/items/{footer,header}.html
	emake || die
}

src_install() {
	emake install DESTDIR=${D} || die
	dodoc README AUTHORS ChangeLog FULLSCREEN.howto NEWBIE NEWS
	prepgamesdirs
}
