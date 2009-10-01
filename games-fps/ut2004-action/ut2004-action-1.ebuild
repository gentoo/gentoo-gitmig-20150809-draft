# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-action/ut2004-action-1.ebuild,v 1.2 2009/10/01 22:20:03 nyhm Exp $

MOD_DESC="Action movie mod"
MOD_NAME="Action"
MOD_DIR="action"

inherit games games-mods

HOMEPAGE="http://www.ateamproductions.net/"
SRC_URI="mirror://beyondunreal/mods/aut-r${PV}-msuc.zip"

LICENSE="freedist"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated opengl"

src_unpack() {
	mkdir -p ${MOD_DIR}
	unzip "${DISTDIR}"/aut-r${PV}-msuc.zip -d ${MOD_DIR}
}
