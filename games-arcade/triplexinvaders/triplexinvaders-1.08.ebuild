# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/triplexinvaders/triplexinvaders-1.08.ebuild,v 1.4 2007/04/15 06:36:14 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="An Alien Invaders style game with 3d graphics"
HOMEPAGE="http://triplexinvaders.infogami.com"
SRC_URI="http://acm.jhu.edu/~arthur/invaders/${P}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="psyco"

DEPEND="app-arch/unzip
	dev-python/pygame
	dev-python/pyopengl
	psyco? ( dev-python/psyco )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}"-gentoo.patch
	sed -i -e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		sound.py \
		util.py \
		hiscore.py \
		options.py || die "sed failed while changing refer to data directory"
}

src_install() {
	local libdir=$(games_get_libdir)

	insinto "${libdir}/${PN}"
	doins -r *.py || die "doins failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r models sound options.conf hiscores || die "doins failed"
	games_make_wrapper ${PN} "python ./invaders.py" "${libdir}/${PN}"
	dodoc README.txt TODO.txt
	prepgamesdirs
}
