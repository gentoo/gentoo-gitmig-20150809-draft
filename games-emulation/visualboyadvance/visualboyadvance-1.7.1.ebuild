# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/visualboyadvance/visualboyadvance-1.7.1.ebuild,v 1.5 2004/04/12 01:00:20 mr_bones_ Exp $

inherit games

DESCRIPTION="gameboy, gameboy color, and gameboy advance emulator"
HOMEPAGE="http://vba.ngemu.com/"
SRC_URI="mirror://sourceforge/vba/VisualBoyAdvance-src-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="mmx debug"

# wrapper script uses sed -i to needs to be in RDEPEND
RDEPEND="virtual/x11
	media-libs/libpng
	sys-libs/zlib
	media-libs/libsdl
	>=sys-apps/sed-4"
DEPEND="${RDEPEND}
	mmx? ( dev-lang/nasm )"

S="${WORKDIR}/VisualBoyAdvance-${PV}"

src_compile() {
	egamesconf \
		--enable-c-core \
		$(use_with debug profiling) \
		$(use_with mmx) \
		|| die
	if ! use debug ; then
		sed -i \
			-e 's:prof/libprof.a::' \
			src/Makefile \
				|| die "sed src/Makefile failed"
	fi
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dogamesbin ${FILESDIR}/visualboyadvance || die "dogamesbin failed"
	insinto ${GAMES_DATADIR}/VisualBoyAdvance
	doins src/VisualBoyAdvance.cfg
	dodoc AUTHORS ChangeLog INSTALL NEWS README README-win.txt
	prepgamesdirs
}
