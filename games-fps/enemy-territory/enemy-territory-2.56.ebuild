# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit games eutils

DESCRIPTION="Return to Castle Wolfenstein: Enemy Territory - standalone multi-player game based on Return to Castle Wolfenstein"
HOMEPAGE="http://www.idsoftware.com/"
SRC_URI="ftp://3dgamers.in-span.net/pub/3dgamers3/games/wolfensteinet/et-linux-2.55.x86.run
	ftp://theuser:Xyz3y@ftp4.3dgamers.com/pub/3dgamers/games/wolfensteinet/et-linux-2.55.x86.run
	http://3dgamers.planetmirror.com/pub/3dgamers/games/wolfensteinet/et-linux-2.55.x86.run
	ftp://freeftp.game.net/pub/games/enemyterritory/full_game/et-linux-2.55.x86.run
	http://sjcredirvip.xlontech.net/100083/games/wolfensteinet/et-linux-${PV}-update.x86.run
	ftp://3dgamers.in-span.net/pub/3dgamers3/games/wolfensteinet/et-linux-${PV}-update.x86.run
	ftp://theuser:Xyz3y@ftp4.3dgamers.com/pub/3dgamers/games/wolfensteinet/et-linux-${PV}-update.x86.run"

LICENSE="RTCW-ETEULA"
SLOT="0"
KEYWORDS="x86"
IUSE="dedicated opengl"
RESTRICT="nomirror nostrip"

DEPEND="virtual/glibc"
RDEPEND="dedicated? ( app-misc/screen )
	!dedicated? ( virtual/opengl )
	opengl? ( virtual/opengl )"

S=${WORKDIR}

pkg_setup() {
	check_license || die "License check failed"
	games_pkg_setup
}

src_unpack() {
	unpack_makeself et-linux-2.55.x86.run
	unpack_makeself et-linux-2.56-update.x86.run
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir}

	cp -r Docs pb etmain ${D}/${dir}/

	exeinto ${dir} ; doexe bin/Linux/x86/* openurl.sh
	insinto ${dir} ; doins CHANGES v1.02_Readme.htm
	insinto /usr/share/pixmaps ; doins ET.xpm

	dogamesbin ${FILESDIR}/et
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/et
	if [ "`use dedicated`" ];
	then
		dogamesbin ${FILESDIR}/et-ded
		dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/et-ded
		dosed "s:GAMES_USER_DED:${GAMES_USER_DED}:" ${GAMES_BINDIR}/et-ded
		exeinto /etc/init.d
		newexe ${FILESDIR}/et-ded.rc et-ded
		dosed "s:GENTOO_DIR:${dir}:" /etc/init.d/et-ded
	fi

	prepgamesdirs
	make_desktop_entry et "Enemy Territory" ET.xpm
}

pkg_postinst() {
	echo
	einfo "To play the game run:"
	einfo " et"

	if [ "`use dedicated`" ];
	then
		echo
		einfo "To start a dedicated server run:"
		einfo " /etc/init.d/et-ded start"
		echo
		einfo "To run the dedicated server at boot, type:"
		einfo " rc-update add et-ded default"
		echo
		einfo "The dedicated server is started under the ${GAMES_USER_DED} user account"
	fi

	games_pkg_postinst
}
