# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-redorchestra/ut2004-redorchestra-3.3-r2.ebuild,v 1.5 2009/10/09 04:27:05 nyhm Exp $

EAPI=2

MOD_DESC="a World War II mod based on the Russian front"
MOD_NAME="Red Orchestra"
MOD_DIR="RedOrchestra"
MOD_ICON="red.orchestra.xpm"

inherit eutils games games-mods

HOMEPAGE="http://redorchestramod.gameservers.net/"
SRC_URI="mirror://liflg/red.orchestra_${PV}-english.run
	mirror://liflg/red.orchestra_summer.offensive.map.pack-addon.run"

LICENSE="freedist"
KEYWORDS="amd64 x86"
IUSE="dedicated opengl"

src_unpack() {
	unpack_makeself red.orchestra_${PV}-english.run
	unpack_makeself red.orchestra_summer.offensive.map.pack-addon.run
	unpack ./*.bz2
}

src_prepare() {
	mv -f red.orchestra.xpm ${MOD_DIR} || die
	rm -rf bin setup.data
	rm -f 3355* README* *.bz2 *.sh
	rm -f StaticMeshes/BenTropicalSM01.usx Textures/BenTropical01.utx
}
