# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythgame/mythgame-0.16.ebuild,v 1.2 2004/12/05 01:01:18 iggy Exp $

inherit myth

DESCRIPTION="Game emulator module for MythTV."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/${P}.tar.bz2"
IUSE="debug nls"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"

DEPEND=">=sys-apps/sed-4
	sys-libs/zlib
	|| ( ~media-tv/mythtv-${PV} ~media-tv/mythfrontend-${PV} )"

setup_pro() {
	return 0
}

src_install () {
	myth_src_install

	dodoc gamelist.xml
}
