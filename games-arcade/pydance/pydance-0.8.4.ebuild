# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/pydance/pydance-0.8.4.ebuild,v 1.1 2004/01/14 17:40:55 vapier Exp $

inherit games

DESCRIPTION="pyDance is a DDR clone for linux written in Python"
HOMEPAGE="http://www.icculus.org/pyddr/"
SRC_URI="http://www.icculus.org/pyddr/${P}.tar.gz"

LICENSE="X11"
SLOT="0"
KEYWORDS="x86"

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
		constants.py docs/man/pydance.6 \
		|| die "sed failed"
}

src_install() {
	local dir="${GAMES_DATADIR}/${PN}"

	insinto ${dir}
	doins *.py || die "doins failed"
	cp -R {sound,images,utils,themes} "${D}${dir}/" || die "cp failed"

	insinto ${GAMES_SYSCONFDIR}
	newins pydance.posix.cfg pydance.cfg

	games_make_wrapper pydance "python ./pydance.py" "${dir}"

	dodoc BUGS CREDITS ChangeLog HACKING README TODO
	dohtml docs/README.html
	doman docs/man/*
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "If you want to use a DDR pad with pyDance,"
	einfo "all you need to do is emerge the games-arcade/ddrmat kernel module."
}
