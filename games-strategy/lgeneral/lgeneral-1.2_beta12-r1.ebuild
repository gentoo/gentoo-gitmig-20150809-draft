# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/lgeneral/lgeneral-1.2_beta12-r1.ebuild,v 1.4 2007/01/15 22:36:18 nyhm Exp $

inherit eutils autotools games

MY_P="${P/_/}"
MY_P="${MY_P/beta/beta-}"
DESCRIPTION="A Panzer General clone written in SDL"
HOMEPAGE="http://lgames.sourceforge.net/index.php?project=LGeneral"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz
	mirror://sourceforge/${PN}/pg-data.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND="media-libs/libsdl
	media-libs/sdl-mixer
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}"/${P}-gentoo-path.patch \
		"${FILESDIR}"/${P}-gettext.patch \
		"${FILESDIR}"/${P}-64bit.patch \
		"${FILESDIR}"/${P}-build.patch

	cp /usr/share/gettext/config.rpath .
	rm -f missing
	eautoreconf

	# Build a temporary lgc-pg that knows about ${WORKDIR}:
	cp -pPR "${S}" "${WORKDIR}"/tmp-build || die "cp failed"
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}:" \
		-e "s:@D@::" \
		{lgc-pg,src}/misc.c \
		|| die "sed failed"

	cd "${WORKDIR}"/tmp-build
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}:" \
		-e "s:@D@:${D}:" \
		{lgc-pg,src}/misc.c \
		|| die "sed failed (tmp)"
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable nls) \
		|| die
	emake || die "emake failed"

	# Build the temporary lgc-pg:
	cd "${WORKDIR}"/tmp-build
	egamesconf \
		--disable-dependency-tracking \
		--disable-nls \
		--datadir="${D}/${GAMES_DATADIR}" \
		|| die
	emake || die "emake failed (tmp)"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	keepdir "${GAMES_DATADIR}"/${PN}/{ai_modules,music,terrain}

	# Generate scenario data:
	SDL_VIDEODRIVER=dummy "${WORKDIR}"/tmp-build/lgc-pg/lgc-pg \
		-s "${WORKDIR}"/pg-data \
		-d "${D}/${GAMES_DATADIR}"/${PN} \
		|| die "Failed to generate scenario data"

	dodoc AUTHORS ChangeLog README.lgeneral README.lgc-pg TODO
	newicon lgeneral48.png ${PN}.png
	make_desktop_entry ${PN} LGeneral
	prepgamesdirs
}
