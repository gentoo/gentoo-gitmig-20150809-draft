# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/monsterz/monsterz-0.4.1.ebuild,v 1.1 2005/03/19 00:08:20 vapier Exp $

inherit games eutils

DESCRIPTION="a little puzzle game, similar to the famous Bejeweled or Zookeeper"
HOMEPAGE="http://sam.zoy.org/projects/monsterz/"
SRC_URI="http://sam.zoy.org/projects/monsterz/monsterz-0.4.1.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-python/pygame"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.patch
	sed -i \
		-e "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}:" \
		-e "s:GENTOO_SCOREFILE:${GAMES_STATEDIR}/${PN}.scores:" \
		monsterz.py || die
}

src_install() {
	local dir=${GAMES_DATADIR}/${PN}
	insinto ${dir}
	doins *.wav *.s3m *.png || die "doins failed"
	newgamesbin monsterz.py ${PN} || die "dobin failed"
	dodir "${GAMES_STATEDIR}"
	touch "${D}/${GAMES_STATEDIR}"/${PN}.scores
	dodoc README AUTHORS TODO INSTALL
	prepgamesdirs
	fperms g+w "${GAMES_STATEDIR}"/${PN}.scores
}
