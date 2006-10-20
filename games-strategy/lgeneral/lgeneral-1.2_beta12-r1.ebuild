# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/lgeneral/lgeneral-1.2_beta12-r1.ebuild,v 1.3 2006/10/20 21:01:59 tupone Exp $

inherit eutils autotools games

DATA=pg-data
MY_P="${P/_/}"
MY_P="${MY_P/beta/beta-}"
DESCRIPTION="A Panzer General clone written in SDL"
HOMEPAGE="http://lgames.sourceforge.net/index.php?project=LGeneral"
SRC_URI="mirror://sourceforge/lgeneral/${MY_P}.tar.gz
	mirror://sourceforge/lgeneral/${DATA}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-mixer"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}"-gentoo-path.patch \
		"${FILESDIR}"/${P}-gettext.patch \
		"${FILESDIR}"/${P}-64bit.patch
	eautoreconf
	# Build a temporary lgc-pg that knows about /var/tmp/portage in work/lgc-pg:
	cp -pPR "${S}" "${WORKDIR}/lgc-pg" || die "cp failed."
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}:" \
		-e "s:@D@::" \
		src/misc.c \
		lgc-pg/misc.c
	cd "${WORKDIR}"/lgc-pg
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}:" \
		-e "s:@D@:${D}:" \
		src/misc.c \
		lgc-pg/misc.c
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		|| die "egamesconf failed"
	emake || die "emake failed"

	# Build the temporary lgc-pg:
	cd "${WORKDIR}/lgc-pg"
	egamesconf --datadir="${D}/${GAMES_DATADIR}" \
		|| die "lgc-gc egamesconf failed"
	emake || die "lgc-gc emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed."
	keepdir "${GAMES_DATADIR}/${PN}/"{ai_modules,music,terrain}

	# Generate scenario data:
	SDL_VIDEODRIVER=dummy "${WORKDIR}"/lgc-pg/lgc-pg/lgc-pg \
		-s "${WORKDIR}/${DATA}" \
		-d ${D}"${GAMES_DATADIR}/${PN}" \
		|| die "Failed to generate scenario data."

	dodoc AUTHORS ChangeLog README.lgeneral README.lgc-pg TODO
	newicon lgeneral48.png ${PN}.png
	make_desktop_entry lgeneral LGeneral
	prepgamesdirs
}
