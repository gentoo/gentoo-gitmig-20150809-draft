# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-cpma/quake3-cpma-1.48.ebuild,v 1.2 2011/11/10 16:05:01 mr_bones_ Exp $

EAPI=2

MOD_DESC="advanced FPS competition mod"
MOD_NAME="Challenge Pro Mode Arena"
MOD_DIR="cpma"

inherit games games-mods

HOMEPAGE="http://www.promode.org/"
SRC_URI="http://promode.ru/files/cpma${PV//.}-nomaps.zip
	http://www.promode.org/files/cpma-mappack-full.zip"

LICENSE="as-is"
KEYWORDS="~ppc ~x86"
IUSE="dedicated opengl"

src_prepare() {
	mv -f *.pk3 ${MOD_DIR} || die
}

pkg_postinst() {
	games-mods_pkg_postinst
	elog "To enable bots: +bot_enable 1"
}
