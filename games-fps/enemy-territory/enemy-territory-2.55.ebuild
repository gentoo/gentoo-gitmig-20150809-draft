# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit games eutils

DESCRIPTION="Return to Castle Wolfenstein: Enemy Territory - standalone multi-player game based on Return to Castle Wolfenstein"
HOMEPAGE="http://www.idsoftware.com/"
SRC_URI="ftp://ftp.gameaholic.com/pub/demos/et-linux-${PV}.x86.run
	ftp://ftp.gigabell.net/pub/games/gameaholic/demos/et-linux-${PV}.x86.run
	ftp://ftp.planetmirror.com/pub/gameaholic/demos/et-linux-${PV}.x86.run"

LICENSE="RTCW-ETEULA"
SLOT="0"
KEYWORDS="x86"
IUSE="dedicated opengl"
RESTRICT="nostrip"

DEPEND="virtual/glibc"
RDEPEND="dedicated? ( app-misc/screen )
	!dedicated? ( virtual/opengl )
	opengl? ( virtual/opengl )"

S=${WORKDIR}

src_unpack() {
	unpack_makeself
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir}

	cp -r Docs pb etmain ${D}/${dir}/

	exeinto ${dir} ; doexe bin/Linux/x86/* openurl.sh
	insinto ${dir} ; doins CHANGES
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
