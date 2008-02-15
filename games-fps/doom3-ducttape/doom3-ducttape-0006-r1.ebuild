# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3-ducttape/doom3-ducttape-0006-r1.ebuild,v 1.2 2008/02/15 00:33:29 wolf31o2 Exp $

MOD_DESC="sticks flashlights to your machinegun and shotgun"
MOD_NAME="Duct Tape"
MOD_DIR="ducttape"

inherit games games-mods

HOMEPAGE="http://ducttape.glenmurphy.com/"
SRC_URI="http://ducttape.glenmurphy.com/ducttape${PV}.zip"

LICENSE="as-is"

RDEPEND="games-fps/doom3"

S=${WORKDIR}

src_unpack() {
	games-mods_src_unpack
	mkdir -p ${MOD_DIR}
	mv pak008.pk4 ${MOD_DIR} || die
}

pkg_postinst() {
	games-mods_pkg_postinst

	elog "To use old saved games with this mod, run:"
	echo
	elog "mkdir -p ~/.doom3/ducttape"
	elog "cp -r ~/.doom3/base/savegames ~/.doom3/ducttape"
	echo
}
