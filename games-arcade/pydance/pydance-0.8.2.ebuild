# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/pydance/pydance-0.8.2.ebuild,v 1.2 2004/02/20 06:20:00 mr_bones_ Exp $

inherit games

DESCRIPTION="Dance Dance Revolution!  You need this game more than Frozen Bubble"
HOMEPAGE="http://www.icculus.org/pyddr/"
SRC_URI="http://www.icculus.org/pyddr/${P}.tar.gz"

LICENSE="X11"
KEYWORDS="x86"
SLOT="0"
IUSE=""

RDEPEND="dev-python/pygame
	media-libs/libvorbis
	media-libs/sdl-mixer"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"
PDEPEND="games-arcade/pydance-songs"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s:/etc/:${GAMES_SYSCONFDIR}/:" \
			constants.py docs/man/pydance.6 || \
				die "sed failed"
}

src_install() {
	local dir="${GAMES_DATADIR}/${PN}"

	insinto ${dir}
	doins *.py || die "doins failed"
	cp -R {sound,images,utils,themes} "${D}${dir}/"  || die "cp failed"

	insinto ${GAMES_SYSCONFDIR}
	newins pydance.posix.cfg pydance.cfg             || die "newins failed"

	dogamesbin ${FILESDIR}/pydance                   || die "dogamesbin failed"
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/pydance

	dodoc BUGS CREDITS ChangeLog HACKING README TODO || die "dodoc failed"
	dohtml docs/README.html                          || die "dohtml failed"
	doman docs/man/*                                 || die "doman failed"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "Emerge the games-arcade/ddrmat package to install"
	einfo "the ddrmat kernel module, which allows you to use"
	einfo "a DDR mat with pydance."
}
