# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/visualboyadvance/visualboyadvance-1.7.ebuild,v 1.3 2004/03/31 06:57:03 mr_bones_ Exp $

inherit games

DESCRIPTION="gameboy, gameboy color, and gameboy advance emulator"
HOMEPAGE="http://vboy.emuhq.com/"
SRC_URI="mirror://sourceforge/vba/VisualBoyAdvance-src-${PV}.tar.gz
	mirror://gentoo/${P}-zutil.h-1.2.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="mmx debug"

RDEPEND="virtual/x11
	media-libs/libpng
	sys-libs/zlib
	media-libs/libsdl"
DEPEND="${RDEPEND}
	mmx? ( dev-lang/nasm )
	>=sys-apps/sed-4"

S="${WORKDIR}/VisualBoyAdvance-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s:@LIBTOOL@:/usr/bin/libtool:" \
		`find -name Makefile.in` \
		|| die "sed Makefile.in failed"
	cd win32/include/png
	for f in * ; do
		[ -e /usr/include/${f} ] \
			&& rm ${f} && ln -s /usr/include/${f}
	done
	cd ../zlib
	for f in * ; do
		[ -e /usr/include/${f} ] \
			&& rm ${f} && ln -s /usr/include/${f}
	done
	has_version '>=sys-libs/zlib-1.2' \
		&& unpack ${P}-zutil.h-1.2.bz2 \
		&& mv ${P}-zutil.h-1.2 zutil.h
}

src_compile() {
	egamesconf \
		--enable-c-core \
		`use_with debug profiling` \
		`use_with mmx` \
		|| die
	if [ ! `use debug` ] ; then
		sed -i \
			-e 's:prof/libprof.a::' \
			src/Makefile \
			|| die "sed src/Makefile failed"
	fi
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dogamesbin ${FILESDIR}/visualboyadvance
	insinto ${GAMES_DATADIR}/VisualBoyAdvance
	doins src/VisualBoyAdvance.cfg
	dodoc AUTHORS ChangeLog INSTALL NEWS README README-win.txt
	prepgamesdirs
}
