# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/jardinains/jardinains-2.0.ebuild,v 1.1 2007/02/02 15:18:50 humpback Exp $

inherit eutils games

DESCRIPTION="Arkanoid with Gnomes"
HOMEPAGE="http://www.jardinains2.com"
SRC_URI="mirror://gentoo/JN2_1_FREE_LIN.tar.gz"

LICENSE="jardinains"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="strip"

DEPEND=""
RDEPEND="virtual/opengl
	amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.0-r1 )"

dir="${GAMES_PREFIX_OPT}/${PN}"
Ddir="${D}/${dir}"

src_unpack() {
	unpack JN2_1_FREE_LIN.tar.gz
	cd ${WORKDIR}
	mv "Jardinains 2!" ${P}
	cd ${S}
	epatch ${FILESDIR}/strings-pt.patch
}

src_install() {
	exeinto ${dir}
	doexe jardinains
	insinto ${dir}
	cp -r LICENSE.txt data help "${Ddir}" || die "cp failed"

	games_make_wrapper jardinains ./jardinains "${dir}" "${dir}"


	make_desktop_entry jardinains "Jardinains 2"
	touch "${Ddir}/data/prefs.xml"
	prepgamesdirs
	chmod g+rw "${Ddir}/data/prefs.xml"
	chmod -R g+rw "${Ddir}/data/players"

}

pkg_postinst() {
	einfo "Due to the way this software is designed all user preferences for"
	einfo "graphics, audio and other in game data are shared among all users"
	einfo "of the computer. For that reason some files in the instalation   "
	einfo "folder are writable by any user in the games group."
}
