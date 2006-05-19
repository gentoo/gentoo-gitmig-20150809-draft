# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/enemy-territory-truecombat/enemy-territory-truecombat-0.48.ebuild,v 1.1 2006/05/19 21:59:32 wolf31o2 Exp $

MOD_DESC="True Combat"
MOD_NAME=tcetest
inherit games games-etmod

MY_PV=${PV//.}

HOMEPAGE="http://truecombat.com/"
SRC_URI="http://www.truecombat.us/files/tce-linux_046_full.zip
	http://www.truecombat.us/files/tce-linux_${MY_PV}_patch.zip"

LICENSE="GPL-2"
