# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/visualboyadvance/visualboyadvance-1.7.2.ebuild,v 1.1 2004/08/15 06:57:12 vapier Exp $

inherit games eutils

DESCRIPTION="gameboy, gameboy color, and gameboy advance emulator"
HOMEPAGE="http://vba.ngemu.com/"
SRC_URI="mirror://sourceforge/vba/VisualBoyAdvance-src-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE="mmx debug"

RDEPEND="virtual/x11
	media-libs/libpng
	sys-libs/zlib
	media-libs/libsdl"
DEPEND="${RDEPEND}
	mmx? ( dev-lang/nasm )"

S="${WORKDIR}/VisualBoyAdvance-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-homedir.patch
}

src_compile() {
	egamesconf \
		--enable-c-core \
		$(use_with debug profiling) \
		$(use_with mmx) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	insinto ${GAMES_DATADIR}/VisualBoyAdvance
	doins src/VisualBoyAdvance.cfg
	dodoc AUTHORS ChangeLog INSTALL NEWS README README-win.txt
	prepgamesdirs
}
