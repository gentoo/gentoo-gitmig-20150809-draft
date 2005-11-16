# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/halflife-steam/halflife-steam-2.0.ebuild,v 1.11 2005/11/16 03:24:56 vapier Exp $

inherit eutils games

DESCRIPTION="client for Valve Software's Steam content delivery program"
HOMEPAGE="http://www.steampowered.com/"
SRC_URI="http://www.steampowered.com/download/hldsupdatetool.bin"

LICENSE="ValveServer"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""
RESTRICT="mirror"

S=${WORKDIR}

src_unpack() {
	unpack_pdv hldsupdatetool.bin 4
	chmod a+x steam
}

src_install() {
	exeinto "${GAMES_PREFIX_OPT}"/halflife
	doexe steam || die

	newinitd "${FILESDIR}"/hlds.rc hlds
	sed -i \
		-e "s:@GAMES_USER@:${GAMES_USER_DED}:" \
		-e "s:@GAMES_GROUP@:${GAMES_GROUP}:" \
		"${D}"/etc/init.d/hlds || die "sed init.d"
	newconfd "${FILESDIR}"/hlds.confd hlds
	sed -i \
		-e "s:@GAMESDIR@:${GAMES_PREFIX_OPT}/halflife:" \
		"${D}"/etc/conf.d/hlds || die "sed conf.d"

	games_make_wrapper steam ./steam "${GAMES_PREFIX_OPT}"/halflife "${GAMES_PREFIX_OPT}"/halflife

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	einfo 'Steam Usage !  (note: please do this as root)'
	einfo '1. Run `steam` to update itself.'
	einfo '2. Run `steam` again to get help menu.'
	einfo '3. Update the halflife modules you want:'
	einfo "     steam -command update -game 'Counter-Strike Source' -dir ${GAMES_PREFIX_OPT}/halflife"
	einfo "     steam -command update -game cstrike -dir ${GAMES_PREFIX_OPT}/halflife"
	einfo "     steam -command update -game tfc -dir ${GAMES_PREFIX_OPT}/halflife"
	einfo "     steam -command update -game valve -dir ${GAMES_PREFIX_OPT}/halflife"
	einfo '     *Note: tfc contains tfc, dmc, and ricochet mods'
	einfo '5. After your first update, you only have to run:'
	einfo '     steam -update "Counter-Strike Source"'
	einfo '     steam -update cstrike'
	einfo '     steam -update tfc'
	einfo '     steam -update valve'
	echo
	einfo "For more info, see ${GAMES_PREFIX_OPT}/halflife"
}
