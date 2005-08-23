# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/lgeneral/lgeneral-1.2_beta2.ebuild,v 1.6 2005/08/23 19:09:11 wolf31o2 Exp $

inherit eutils games

DATA=pg-data
MY_P="${P/_/}"
MY_P="${MY_P/beta/beta-}"
DESCRIPTION="A Panzer General clone written in SDL"
HOMEPAGE="http://lgames.sourceforge.net/index.php?project=LGeneral"
SRC_URI="mirror://sourceforge/lgeneral/${MY_P}.tar.gz
	mirror://sourceforge/lgeneral/${DATA}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2.4
	>=media-libs/sdl-mixer-1.2.3"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	# Build a temporary lgc-pg that knows about /var/tmp/portage in work/lgc-pg:
	cp -dpR "${S}" "${WORKDIR}/lgc-pg" || die "cp failed."
}

src_compile() {
	egamesconf --datadir="${GAMES_DATADIR}/../" || die
	emake || die "emake failed"

	# Build the temporary lgc-pg:
	cd "${WORKDIR}/lgc-pg"
	egamesconf --datadir="${D}/${GAMES_DATADIR_BASE}" || die
	cd lgc-pg
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed."
	keepdir "${GAMES_DATADIR}/${PN}/"{ai_modules,music}

	# Generate scenario data:
	"${WORKDIR}/lgc-pg/lgc-pg/lgc-pg" \
		-s "${WORKDIR}/${DATA}" \
		-d "${D}/${GAMES_DATADIR}/lgeneral" \
		|| die "Failed to generate scenario data."

	dodoc AUTHORS ChangeLog README.lgeneral README.lgc-pg TODO
	prepgamesdirs
}
