# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/stella/stella-2.0.1.ebuild,v 1.2 2006/01/08 01:40:33 malc Exp $

inherit eutils games

DESCRIPTION="Stella Atari 2600 VCS Emulator"
HOMEPAGE="http://stella.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="opengl"

DEPEND="media-libs/libsdl
	media-libs/libpng
	opengl? ( virtual/opengl )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:/etc:${GAMES_SYSCONFDIR}:g" \
		src/macosx/OSystemMACOSX.cxx \
		src/unix/OSystemUNIX.cxx \
		src/unix/stella.spec \
		src/psp/OSystemPSP.cxx \
		docs/stella.html \
		docs/debugger.html \
		Makefile \
		|| die "sed failed"
	sed -i \
		-e "/icons/d" \
		Makefile \
		|| die "sed failed"
}

src_compile() {
	# not an autoconf script
	./configure \
		--prefix="/usr" \
		--bindir="${GAMES_BINDIR}" \
		--docdir="/usr/share/doc/${PF}" \
		--datadir="${GAMES_DATADIR}/${PN}" \
		$(use_enable opengl) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	doicon src/common/stella.xpm
	make_desktop_entry stella Stella stella.xpm
	prepgamesdirs
}
