# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythgame/mythgame-0.20.1.ebuild,v 1.2 2007/06/12 16:27:05 cardoe Exp $

inherit mythtv-plugins

DESCRIPTION="Game emulator module for MythTV."
IUSE=""
KEYWORDS="amd64 ppc x86"

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}"

src_install () {
	mythtv-plugins_src_install || die "install failed"

	dodoc gamelist.xml
}
