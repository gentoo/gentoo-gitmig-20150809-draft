# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/stella/stella-2.5.1.ebuild,v 1.2 2008/05/02 18:42:50 nyhm Exp $

inherit eutils games

DESCRIPTION="Stella Atari 2600 VCS Emulator"
HOMEPAGE="http://stella.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="opengl"

DEPEND="media-libs/libsdl
	media-libs/libpng
	opengl? ( virtual/opengl )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch
	sed -i \
		-e '/INSTALL/s/-s //' \
		-e '/strip/d' \
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
		--datadir="${GAMES_DATADIR}" \
		$(use_enable opengl) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	doicon src/common/stella.xpm
	make_desktop_entry stella Stella
	prepgamesdirs
}
