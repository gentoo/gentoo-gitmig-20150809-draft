# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-ruinhunters/quake3-ruinhunters-1.0a-r1.ebuild,v 1.2 2009/10/01 21:47:16 nyhm Exp $

MOD_DESC="a anime/fantasy mod with cartoonish characters and arcade-like gameplay"
MOD_NAME="Ruin Hunters"
MOD_DIR="ruin"

inherit games games-mods

SRC_URI="mirror://gentoo/ruin_hunters_v10.zip
	mirror://gentoo/ruin_hunters_v10a_patch.zip
	http://www.mirrorservice.org/sites/www.ibiblio.org/gentoo/distfiles/ruin_hunters_v10a_patch.zip
	http://www.mirrorservice.org/sites/www.ibiblio.org/gentoo/distfiles/ruin_hunters_v10.zip"
HOMEPAGE="http://planetquake.gamespy.com/View.php?view=Quake3.Detail&id=1824"

LICENSE="freedist"
KEYWORDS="-* ~amd64 ~ppc ~x86"
IUSE="dedicated opengl"
