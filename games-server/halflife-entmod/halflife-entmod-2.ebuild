# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/halflife-entmod/halflife-entmod-2.ebuild,v 1.6 2004/11/03 00:32:02 vapier Exp $

inherit games

DESCRIPTION="adds real-time entity control for admins"
SRC_URI="http://www.adminop.net/AdminOP/EntMod_lin.zip"
HOMEPAGE="http://www.adminop.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

RDEPEND="games-server/halflife-metamod"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}"

src_install() {
	local dir=${GAMES_PREFIX_OPT}/halflife/addons/entmod

	dodir ${dir}
	cp -rf entmod_readme.txt sound addons/EntMod/* ${D}/${dir}/

	prepgamesdirs
}
