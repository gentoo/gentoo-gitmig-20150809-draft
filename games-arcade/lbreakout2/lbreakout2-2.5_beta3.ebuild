# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/lbreakout2/lbreakout2-2.5_beta3.ebuild,v 1.4 2004/03/19 09:23:15 mr_bones_ Exp $

inherit flag-o-matic games

MY_P=${PN}-2.5beta-3
DESCRIPTION="Breakout clone written with the SDL library"
HOMEPAGE="http://lgames.sourceforge.net/"
SRC_URI="mirror://sourceforge/lgames/${MY_P}.tar.gz
	mirror://gentoo/lbreakout2-levelsets-20040319.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="virtual/glibc
	media-libs/libpng
	sys-libs/zlib
	>=media-libs/libsdl-1.1.5
	media-libs/sdl-mixer"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${MY_P}.tar.gz
	mkdir ${S}/levels
	cd ${S}/levels
	unpack lbreakout2-levelsets-20040319.tar.gz
}

src_compile() {
	filter-flags -O?
	egamesconf \
		--with-highscore-path="${GAMES_STATEDIR}" \
		--with-doc-path="/usr/share/doc/${PF}" \
		--datadir="${GAMES_DATADIR_BASE}" \
		|| die
	emake || die "emake failed"
}

src_install() {
	egamesinstall \
		inst_dir="${D}/${GAMES_DATADIR}/${PN}" \
		hi_dir="${D}/${GAMES_STATEDIR}/" \
		doc_dir="${D}/usr/share/doc/${PF}" \
			|| die

	insinto ${GAMES_DATADIR}/lbreakout2/levels
	doins levels/* || die "doins failed"

	dodoc AUTHORS README TODO ChangeLog
	mv "${D}/usr/share/doc/${PF}/lbreakout2" "${D}/usr/share/doc/${PF}/html"
	prepgamesdirs
}
