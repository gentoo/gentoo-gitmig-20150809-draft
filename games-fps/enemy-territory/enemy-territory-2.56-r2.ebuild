# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit games

DESCRIPTION="Return to Castle Wolfenstein: Enemy Territory - standalone multi-player game based on Return to Castle Wolfenstein"
HOMEPAGE="http://www.idsoftware.com/"
SRC_URI="ftp://3dgamers.in-span.net/pub/3dgamers4/games/wolfensteinet/et-linux-${PV}-2.x86.run
	http://3dgamers.gameservers.net/pub/3dgamers/games/wolfensteinet/et-linux-${PV}-2.x86.run
	http://downloadsx-2.planetmirror.com/pub/3dgamers/games/wolfensteinet/et-linux-${PV}-2.x86.run"

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

pkg_nofetch() {
	einfo "Please visit one of these mirrors and download ${A}"
	einfo "http://www.fileplanet.com/files/120000/124801.shtml"
	einfo "http://www.fileshack.com/file.x?fid=2743"
	einfo "http://www.3dgamers.com/games/wolfensteinet/"
	einfo "Then just put the file in ${DISTDIR}"
}

pkg_setup() {
	check_license || die "License check failed"
	games_pkg_setup
}

src_unpack() {
	unpack_makeself
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
	if [ `use dedicated` ] ; then
		dogamesbin ${FILESDIR}/et-ded
		dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/et-ded
		exeinto /etc/init.d ; newexe ${FILESDIR}/et-ded.rc et-ded
		dosed "s:GAMES_USER_DED:${GAMES_USER_DED}:" /etc/init.d/et-ded
		dosed "s:GENTOO_DIR:${GAMES_BINDIR}:" /etc/init.d/et-ded
		insinto /etc/conf.d ; newins ${FILESDIR}/et-ded.conf.d et-ded
	fi

	# TODO: move this to /var/ perhaps ?
	dodir ${dir}/etwolf-homedir
	dosym ${dir}/etwolf-homedir ${GAMES_PREFIX}/.etwolf
	keepdir ${dir}/etwolf-homedir

	prepgamesdirs
	make_desktop_entry et "Enemy Territory" ET.xpm
	chmod g+rw ${D}/${dir} ${D}/${dir}/etwolf-homedir
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "To play the game run:"
	einfo " et"

	if [ `use dedicated` ] ; then
		echo
		einfo "To start a dedicated server run:"
		einfo " /etc/init.d/et-ded start"
		echo
		einfo "To run the dedicated server at boot, type:"
		einfo " rc-update add et-ded default"
		echo
		einfo "The dedicated server is started under the ${GAMES_USER_DED} user account"
	fi
}
