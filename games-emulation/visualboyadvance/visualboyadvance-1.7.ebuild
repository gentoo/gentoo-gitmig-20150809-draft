# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/visualboyadvance/visualboyadvance-1.7.ebuild,v 1.1 2004/01/02 00:03:32 mr_bones_ Exp $

inherit games

S="${WORKDIR}/VisualBoyAdvance-${PV}"
DESCRIPTION="gameboy, gameboy color, and gameboy advance emulator"
HOMEPAGE="http://vboy.emuhq.com/"
SRC_URI="mirror://sourceforge/vba/VisualBoyAdvance-src-${PV}.tar.gz"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

IUSE="mmx debug"

DEPEND="virtual/x11
	mmx? ( dev-lang/nasm )
	media-libs/libpng
	sys-libs/zlib
	media-libs/libsdl
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	sed -i \
		-e "s:@LIBTOOL@:/usr/bin/libtool:" `find -name Makefile.in` || \
			die "sed Makefile.in failed"
}

src_compile() {
	egamesconf \
		--enable-c-core \
		`use_with debug profiling` \
		`use_with mmx` || \
			die
	if [ ! `use debug` ] ; then
		sed -i \
			-e 's:prof/libprof.a::' src/Makefile || \
				die "sed src/Makefile failed"
	fi
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install                 || die "make install failed"
	dogamesbin "${FILESDIR}/visualboyadvance" || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/VisualBoyAdvance"
	doins src/VisualBoyAdvance.cfg            || die "doins failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README README-win.txt || \
		die "dodoc failed"
	prepgamesdirs
}
