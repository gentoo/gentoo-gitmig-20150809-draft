# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/visualboyadvance/visualboyadvance-1.5.1.ebuild,v 1.1 2003/06/21 03:34:01 vapier Exp $

inherit games

S=${WORKDIR}/VisualBoyAdvance-1.5

DESCRIPTION="gameboy, gameboy color, and gameboy advance emulator"
HOMEPAGE="http://vboy.emuhq.com/"
SRC_URI="mirror://sourceforge/vba/VisualBoyAdvance-${PV}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="mmx profiling"

DEPEND="mmx? ( dev-lang/nasm )
	media-libs/libpng
	sys-libs/zlib
	media-libs/libsdl
	virtual/x11"

src_compile() {
	for m in `find -name Makefile.in` ; do
		cp ${m}{,.orig}
		sed -e "s:@LIBTOOL@:/usr/bin/libtool:" ${m}.orig > ${m}
	done

	egamesconf \
		--enable-c-core \
		`use_with profiling` \
		`use_with mmx` \
		|| die
	if [ ! `use profiling` ] ; then
		cp src/Makefile{,.orig}
		sed -e 's:prof/libprof.a::' \
			src/Makefile.orig > src/Makefile
	fi
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dogamesbin ${FILESDIR}/playvisualboyadvance
	insinto ${GAMES_DATADIR}/VisualBoyAdvance
	doins src/VisualBoyAdvance.cfg
	dodoc README README-win.txt INSTALL ChangeLog AUTHORS NEWS
	prepgamesdirs
}
