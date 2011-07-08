# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythgame/mythgame-0.23.1_p25396.ebuild,v 1.2 2011/07/08 16:33:24 cardoe Exp $

EAPI=2
inherit qt4 mythtv-plugins

DESCRIPTION="Game emulator module for MythTV."
IUSE=""
KEYWORDS="amd64 ~ppc x86"

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}"

src_install () {
	mythtv-plugins_src_install

	dodoc gamelist.xml
}
