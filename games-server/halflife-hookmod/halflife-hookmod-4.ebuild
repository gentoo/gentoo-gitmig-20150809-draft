# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/halflife-hookmod/halflife-hookmod-4.ebuild,v 1.3 2004/02/20 07:31:48 mr_bones_ Exp $

inherit games

DESCRIPTION="add a hook feature to any Half-Life mod"
SRC_URI="http://www.adminop.net/AdminOP/HookMod${PV}_lin.zip"
HOMEPAGE="http://www.adminop.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86"

RDEPEND="games-server/halflife-metamod"

S=${WORKDIR}/addons/HookMod

src_install() {
	local dir=${GAMES_PREFIX_OPT}/halflife/addons/hookmod

	dodir ${dir}
	cp -rf ${S}/* ${D}/${dir}/

	prepgamesdirs
}
