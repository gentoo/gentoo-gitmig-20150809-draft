# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/halflife-steam/halflife-steam-2.0_beta.ebuild,v 1.1 2003/09/10 05:51:11 vapier Exp $

inherit games

DESCRIPTION="client for Valve Software's Steam content delivery program"
HOMEPAGE="http://www.steampowered.com/"
SRC_URI="steam.gz Steam_README.txt"

LICENSE="ValveServer"
SLOT="0"
KEYWORDS="-* x86"
RESTRICT="fetch"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Please download ${A} from the following ftp server:"
	einfo "server: ftp.valvesoftware.com"
	einfo "user: hlserver"
	einfo "password: hlserver"
	einfo "directory: Linux/steam"
}

src_unpack() {
	unpack steam.gz
	cp ${DISTDIR}/Steam_README.txt .
}

src_install() {
	exeinto ${GAMES_PREFIX_OPT}/halflife
	doexe steam

	dogamesbin ${FILESDIR}/steam
	dosed "s:GENTOO_DIR:${GAMES_PREFIX_OPT}/halflife:" ${GAMES_BINDIR}/steam

	dodoc Steam_README.txt

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	einfo 'Steam Usage !  (note: please do this as root)'
	einfo '1. Run `steam` to update itself.'
	einfo '2. Run `steam` again to get help menu.'
	einfo '3. Create an account:'
	einfo '     steam -create linux1@here.com comPlexPass "Your hint" "answer"'
	einfo '4. Update the halflife modules you want:'
	einfo "     steam -update cstrike ${GAMES_PREFIX_OPT}/halflife linux1@here.com comPlexPass"
	einfo "     steam -update tfc ${GAMES_PREFIX_OPT}/halflife linux1@here.com comPlexPass"
	einfo "     steam -update valve ${GAMES_PREFIX_OPT}/halflife linux1@here.com comPlexPass"
	einfo '     *Note: tfc contains tfc, dmc, and ricochet mods'
	einfo '5. After your first update, you only have to run:'
	einfo '     steam -update cstrike'
	einfo '     steam -update tfc'
	einfo '     steam -update valve'
	echo
	einfo "For more info, see /usr/share/doc/${PF}/Steam_README.txt.gz"
}
