# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythgame/mythgame-0.20.ebuild,v 1.2 2006/12/24 07:57:48 cardoe Exp $

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
