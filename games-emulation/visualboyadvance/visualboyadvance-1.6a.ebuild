# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/visualboyadvance/visualboyadvance-1.6a.ebuild,v 1.1 2003/09/21 20:46:18 vapier Exp $

inherit games

S=${WORKDIR}/VisualBoyAdvance-${PV}

DESCRIPTION="gameboy, gameboy color, and gameboy advance emulator"
HOMEPAGE="http://vboy.emuhq.com/"
SRC_URI="mirror://sourceforge/vba/VisualBoyAdvance-src-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="mmx debug"

DEPEND="mmx? ( dev-lang/nasm )
	media-libs/libpng
	sys-libs/zlib
	media-libs/libsdl
	virtual/x11"

src_unpack() {
	unpack ${A}
	sed -i "s:@LIBTOOL@:/usr/bin/libtool:" `find -name Makefile.in`
}

src_compile() {
	egamesconf \
		--enable-c-core \
		`use_with debug profiling` \
		`use_with mmx` \
		|| die
	if [ ! `use debug` ] ; then
		cp src/Makefile{,.orig}
		sed -e 's:prof/libprof.a::' \
			src/Makefile.orig > src/Makefile
	fi
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dogamesbin ${FILESDIR}/visualboyadvance
	insinto ${GAMES_DATADIR}/VisualBoyAdvance
	doins src/VisualBoyAdvance.cfg
	dodoc README README-win.txt INSTALL ChangeLog AUTHORS NEWS
	prepgamesdirs
}
