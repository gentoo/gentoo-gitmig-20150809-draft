# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3/quake3-1.31.ebuild,v 1.1 2003/09/09 18:10:14 vapier Exp $

inherit eutils games

DESCRIPTION="Quake III"
SRC_URI="ftp://ftp.idsoftware.com/idstuff/quake3/linux/linuxq3apoint-${PV}.x86.run"
HOMEPAGE="http://www.idsoftware.com/"

LICENSE="Q3AEULA"
SLOT="0"
KEYWORDS="-* x86"
IUSE="${IUSE} X opengl"
RESTRICT="nostrip"

RDEPEND="virtual/glibc
	opengl? ( virtual/opengl )
	X? ( x11-base/xfree )
	dedicated? ( app-misc/screen )"

S=${WORKDIR}

src_unpack() {
	unpack_makeself
}

src_install() {
	dodir /opt/quake3/

	insinto /opt/quake3/baseq3
	doins baseq3/*.pk3
	insinto /opt/quake3/missionpack
	doins missionpack/*.pk3

	exeinto /opt/quake3/
	insinto /opt/quake3/
	doexe bin/x86/{quake3.x86,q3ded} ${FILESDIR}/startq3ded
	doins quake3.xpm README* Q3A_EULA.txt Help/*
	dogamesbin ${FILESDIR}/quake3

	exeinto /etc/init.d
	newexe ${FILESDIR}/q3ded.rc q3ded

	prepgamesdirs /opt/quake3
}

pkg_postinst() {
	enewuser q3 -1 /bin/bash /opt/quake3 ${GAMES_GROUP}

	einfo "You need to copy pak0.pk3 from your Quake3 CD into /opt/quake3/baseq3."
	einfo "Or if you have got a Window installation of Q3 make a symlink to save space."
	echo
	einfo "To start a dedicated server, run"
	einfo "\t/etc/init.d/q3ded start"
	echo
	einfo "The dedicated server is started under the q3 user account."

	games_pkg_postinst
}
