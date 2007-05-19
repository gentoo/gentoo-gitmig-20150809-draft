# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/abuse_sdl/abuse_sdl-0.7.0-r3.ebuild,v 1.2 2007/05/19 11:24:53 tupone Exp $

inherit eutils games

DESCRIPTION="port of Abuse by Crack Dot Com"
HOMEPAGE="http://www.labyrinth.net.au/~trandor/abuse/"
SRC_URI="http://www.labyrinth.net.au/~trandor/abuse/files/${P}.tar.bz2
	http://www.labyrinth.net.au/~trandor/abuse/files/abuse_datafiles.tar.gz
	mirror://gentoo/${P}-patch_debian.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=media-libs/libsdl-1.1.6"
DEPEND="${RDEPEND}
	x11-libs/libXt
	virtual/opengl"

DATA="${WORKDIR}/datafiles"

src_unpack() {
	cd ${WORKDIR}
	unpack ${P}.tar.bz2
	unpack ${P}-patch_debian.tar.bz2

	mkdir ${DATA}
	cd ${DATA}
	unpack abuse_datafiles.tar.gz

	cd "${S}"
	epatch ../${PN}-patch/*
	sed -i -e "s:/var/games:${GAMES_DATADIR}:" \
		src/sdlport/setup.cpp

	# hard-coded path in the default config writer.
	sed -i \
		-e "s:/usr/local/share/games/abuse:${GAMES_DATADIR}/abuse:" \
			src/sdlport/setup.cpp || die "sed src/sdlport/setup.cpp failed"
}

src_compile() {
	egamesconf --datadir="${GAMES_DATADIR_BASE}" || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO

	cd ${DATA}
	dodir ${GAMES_DATADIR}/abuse
	cp -R * ${D}/${GAMES_DATADIR}/abuse

	#fix for #10573 + #11475 ... stupid hippy bug
	cd ${D}/${GAMES_DATADIR}/abuse
	epatch ${FILESDIR}/stupid-fix.patch

	newicon abuse.png ${PN}.png
	make_desktop_entry abuse.sdl "Abuse SDL" ${PN}.png

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "NOTE: If you had previous version of abuse installed"
	elog "you may need to remove ~/.abuse for the game to work correctly."
}
