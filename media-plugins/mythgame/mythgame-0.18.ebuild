# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythgame/mythgame-0.18.ebuild,v 1.1 2005/04/18 08:13:44 eradicator Exp $

inherit myth

DESCRIPTION="Game emulator module for MythTV."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/mythplugins-${PV}.tar.bz2"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND=">=sys-apps/sed-4
	sys-libs/zlib
	|| ( ~media-tv/mythtv-${PV} ~media-tv/mythfrontend-${PV} )"

setup_pro() {
	return 0
}

src_install () {
	myth_src_install || die "install failed"

	dodoc gamelist.xml
}
