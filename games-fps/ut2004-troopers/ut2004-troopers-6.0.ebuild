# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-troopers/ut2004-troopers-6.0.ebuild,v 1.1 2008/09/04 00:58:25 nyhm Exp $

MOD_DESC="Star Wars mod"
MOD_NAME="Troopers"
MOD_BINS="troopers"
MOD_ICON="Help/Troopers.ico"
MOD_DIR="Troopers"

inherit games games-mods

HOMEPAGE="http://www.ut2004troopers.com/"
SRC_URI="mirror://beyondunreal/mods/troopersversion${PV/.}zip.zip"

LICENSE="freedist"

RDEPEND="${CATEGORY}/${GAME}"
