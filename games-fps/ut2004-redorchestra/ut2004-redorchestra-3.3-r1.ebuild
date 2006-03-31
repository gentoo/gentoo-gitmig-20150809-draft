# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-redorchestra/ut2004-redorchestra-3.3-r1.ebuild,v 1.1 2006/03/31 03:33:09 wolf31o2 Exp $

MOD_DESC="Red Orchestra is a World War II mod"
MOD_NAME="Red Orchestra"
MOD_BINS=redorchestra
MOD_TBZ2="red.orchestra red.orchestra_summer.offensive.map.pack-addon"
MOD_ICON=red.orchestra.xpm
inherit games games-ut2k4mod

HOMEPAGE="http://redorchestramod.gameservers.net/"
SRC_URI="red.orchestra_${PV}-english.run
	red.orchestra_summer.offensive.map.pack-addon.run"

LICENSE="freedist"
IUSE=""

src_install() {
	games-ut2k4mod_src_install
	rm -f ${Ddir}/StaticMeshes/BenTropicalSM01.usx \
		${Ddir}/Textures/BenTropical01.utx
}
