# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/pydance/pydance-0.8.1.ebuild,v 1.2 2004/02/20 06:20:00 mr_bones_ Exp $

inherit games

DESCRIPTION="Dance Dance Revolution!  You need this game more than Frozen Bubble"
HOMEPAGE="http://www.icculus.org/pyddr/"
SRC_URI="http://www.icculus.org/pyddr/${P}.tar.gz"

LICENSE="X11"
SLOT="0"
KEYWORDS="x86"

RDEPEND="dev-python/pygame
	media-libs/libvorbis
	media-libs/sdl-mixer"
PDEPEND="games-arcade/pydance-songs"

src_install() {
	local dir=${GAMES_DATADIR}/${PN}
	insinto ${dir}
	doins *.py
	cp -R {sound,images,utils,themes} ${D}/${dir}/

	insinto ${GAMES_SYSCONFDIR}/${PN}
	newins pydance.posix.cfg

	dogamesbin ${FILESDIR}/pydance
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/pydance

	dodoc BUGS CREDITS ChangeLog HACKING README TODO
	dohtml docs/README.html
	doman docs/man/*
}

pkg_postinst() {
	games_pkg_postinst
	einfo "Emerge the games-arcade/ddrmat package to install"
	einfo "the ddrmat kernel module, which allows you to use"
	einfo "a DDR mat with pydance."
}
