# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3-inhell/doom3-inhell-1.1-r1.ebuild,v 1.3 2009/07/13 17:04:47 mr_bones_ Exp $

MOD_DESC="Ultimate Doom-inspired levels for Doom 3"
MOD_NAME="In Hell"
MOD_DIR="inhell"

inherit versionator games games-mods

MY_PV=$(replace_version_separator 1 '')

HOMEPAGE="http://www.doomerland.de.vu/"
SRC_URI="ftp://ftp.dvo.ru/pub/distfiles/in_hell_v${MY_PV}.zip"

LICENSE="as-is"

RDEPEND="games-fps/doom3"

S=${WORKDIR}

src_unpack() {
	games-mods_src_unpack
	mv In_Hell ${MOD_DIR} || die
}
