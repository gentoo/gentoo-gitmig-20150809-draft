# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/smm++/smm++-6.1.1.ebuild,v 1.2 2004/09/04 23:16:11 dholm Exp $

inherit games

MY_PV=${PV//.}
MY_PN=${PN/++}
DESCRIPTION="A MUD client featuing a highly customizable user interface and powerful mapping capabilities"
HOMEPAGE="http://sourceforge.net/projects/smm/"
SRC_URI="mirror://sourceforge/smm/${MY_PN}${MY_PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

RDEPEND=">=dev-tcltk/itcl-3
	dev-tcltk/iwidgets"

S="${WORKDIR}/${MY_PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	rm -rf $(find . -type d -name CVS)
}

src_install() {
	dogamesbin "${FILESDIR}/smm" || die "dogamesbin failed"
	sed -i \
		-e "s:GENTOODIR:${GAMES_DATADIR}/${PN}:" \
		"${D}${GAMES_BINDIR}/smm" \
		|| die "sed failed"
	dodir "${GAMES_DATADIR}/${PN}"
	cp -Rp sources images config "${D}/${GAMES_DATADIR}/${PN}" \
		|| die "cp failed"
	cd docu
	dodoc A_README CHANGES CUSTOMIZE_SMM FEEDBACK MAPS REPORT_BUGS SCRIPTS \
		TODO TROUBLESHOOTING
	prepgamesdirs
}
