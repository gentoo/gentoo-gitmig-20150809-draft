# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-redorchestra/ut2004-redorchestra-3.1.ebuild,v 1.2 2004/11/29 15:35:17 wolf31o2 Exp $

MOD_DESC="Red Orchestra is a World War II mod"
MOD_NAME="Red Orchestra"
MOD_BINS=redorchestra
MOD_TBZ2=red.orchestra
MOD_ICON=RedOrchestra.png
inherit games games-ut2k4mod

HOMEPAGE="http://redorchestramod.gameservers.net/"
SRC_URI="red.orchestra_${PV}-english-1.run"

LICENSE="freedist"
IUSE=""
