# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-redorchestra/ut2004-redorchestra-3.3-r1.ebuild,v 1.2 2006/09/28 19:00:14 wolf31o2 Exp $

MOD_DESC="Red Orchestra is a World War II mod"
MOD_NAME="Red Orchestra"
MOD_BINS=redorchestra
MOD_TBZ2="red.orchestra red.orchestra_summer.offensive.map.pack-addon"
MOD_ICON=red.orchestra.xpm
inherit games games-ut2k4mod

HOMEPAGE="http://redorchestramod.gameservers.net/"
SRC_URI="mirror://liflg/red.orchestra_${PV}-english.run
	mirror://liflg/red.orchestra_summer.offensive.map.pack-addon.run"

LICENSE="freedist"
RESTRICT="mirror strip"
IUSE=""

src_install() {
	games-ut2k4mod_src_install
	rm -f ${Ddir}/StaticMeshes/BenTropicalSM01.usx \
		${Ddir}/Textures/BenTropical01.utx
}
