# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3/quake3-1.32b-r3.ebuild,v 1.3 2004/02/20 06:40:07 mr_bones_ Exp $

inherit games

DESCRIPTION="Quake III Arena - 3rd installment of the classic id 3D first-person shooter"
HOMEPAGE="http://www.idsoftware.com/"
SRC_URI="ftp://ftp.idsoftware.com/idstuff/quake3/linux/linuxq3apoint-${PV}-3.x86.run"

LICENSE="Q3AEULA"
SLOT="0"
KEYWORDS="-* x86"
IUSE="${IUSE} X opengl"
RESTRICT="nostrip"

RDEPEND="virtual/glibc
	opengl? ( virtual/opengl )
	X? ( virtual/x11 )
	dedicated? ( app-misc/screen )"

S=${WORKDIR}

pkg_setup() {
	check_license
	games_pkg_setup
}

src_unpack() {
	unpack_makeself
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir}

	insinto ${dir}/baseq3
	doins baseq3/*.pk3
	mv Docs ${D}/${dir}/
	insinto ${dir}/missionpack
	doins missionpack/*.pk3
	mv pb ${D}/${dir}/

	exeinto ${dir}
	insinto ${dir}
	doexe bin/Linux/x86/{quake3.x86,q3ded}
	doins quake3.xpm README* Q3A_EULA.txt
	dogamesbin ${FILESDIR}/quake3 ${FILESDIR}/q3ded

	exeinto /etc/init.d ; newexe ${FILESDIR}/q3ded.rc q3ded
	insinto /etc/conf.d ; newins ${FILESDIR}/q3ded.conf.d q3ded
	insinto /usr/share/pixmaps
	doins quake3.xpm

	prepgamesdirs
	make_desktop_entry quake3 "Quake III Arena" quake3.xpm
}

pkg_postinst() {
	games_pkg_postinst

	einfo "You need to copy pak0.pk3 from your Quake3 CD into ${dir}/baseq3."
	einfo "Or if you have got a Window installation of Q3 make a symlink to save space."
	echo
	einfo "To start a dedicated server, run"
	einfo "\t/etc/init.d/q3ded start"
	echo
	einfo "The dedicated server is started under the ${GAMES_USER_DED} user account."
}
