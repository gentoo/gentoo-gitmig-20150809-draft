# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/hugo/hugo-2.09.ebuild,v 1.5 2004/07/01 11:15:10 eradicator Exp $

inherit games

DESCRIPTION="PC-Engine (TG16) emulator for linux"
HOMEPAGE="http://www.zeograd.com/"
SRC_URI="http://www.zeograd.com/download/hugo_lin_${PV//.}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="virtual/x11
	virtual/libc
	media-libs/libsdl"

S=${WORKDIR}/hugo-${PV}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir}

	exeinto ${dir}
	doexe hugo || die

	insinto ${dir}/roms
	doins dracx.hcd flipit.pce

	insinto ${dir}/cfg
	doins hugo.ini

	dodoc *.fr *.txt *.es changes faq

	games_make_wrapper hugo ./hugo ${dir}

	prepgamesdirs
}

pkg_postinst() {
	einfo "Online Compatibility List:"
	einfo "     http://www.zeograd.com/compatibility_list.php"
}
