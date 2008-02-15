# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3-opencoop/doom3-opencoop-1.1.ebuild,v 1.2 2008/02/15 00:43:53 wolf31o2 Exp $

MOD_DESC="add coop support to Doom 3"
MOD_NAME="Open Co-op"
MOD_DIR="opencoop"

MAP_VER="1.0"
MY_PN="opencoop"

inherit games games-mods

HOMEPAGE="http://www.d3opencoop.com/"
SRC_URI="http://firedevil.de/downloads/mods/${MY_PN}/${MY_PN}${PV}.zip
	ftp://ftp.planetmirror.com/pub/moddb/2006/03/${MY_PN}${PV}.zip
	ftp://ftp.planetmirror.com/pub/moddb/2006/05/oc_mappack1v${MAP_VER}.zip
	http://www.firedevil.de/downloads/mods/${MY_PN}/oc_mappack1v${MAP_VER}.zip"

LICENSE="as-is"

RDEPEND="games-fps/doom3"

S=${WORKDIR}

src_unpack() {
	games-mods_src_unpack
	mv final/* ${MOD_DIR} || die
}
