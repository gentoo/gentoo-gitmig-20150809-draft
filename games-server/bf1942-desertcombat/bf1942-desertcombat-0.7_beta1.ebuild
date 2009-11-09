# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/bf1942-desertcombat/bf1942-desertcombat-0.7_beta1.ebuild,v 1.4 2009/11/09 22:43:06 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="modern day military modification for BattleField 1942"
HOMEPAGE="http://www.desertcombat.com/"
SRC_URI="desertcombat_0.7n-beta_full_install.run"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RESTRICT="fetch"

DEPEND=">=games-server/bf1942-lnxded-1.6_rc"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Please visit download ${A} from:"
	einfo "http://www.fileplanet.com/dl.aspx?/planetbattlefield/news/desertcombat_0.7n-beta_full_install.run"
	einfo "Then put the files in ${DISTDIR}"
}

src_unpack() {
	unpack_makeself
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/bf1942
	dodir "${dir}"
	mv * "${D}/${dir}/"
	prepgamesdirs
}
