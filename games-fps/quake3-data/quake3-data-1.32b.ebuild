# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-data/quake3-data-1.32b.ebuild,v 1.5 2006/01/05 19:36:09 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="Quake III Arena - data portion"
HOMEPAGE="http://icculus.org/quake3/"
SRC_URI="ftp://ftp.idsoftware.com/idstuff/quake3/linux/linuxq3apoint-${PV}-3.x86.run"

LICENSE="Q3AEULA"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="cdinstall"

RDEPEND=""

S=${WORKDIR}

pkg_setup() {
	games_pkg_setup
	use cdinstall && cdrom_get_cds baseq3/pak0.pk3:Quake3/baseq3/pak0.pk3
}

src_unpack() {
	unpack_makeself
}

src_install() {
	ebegin "Copying files from linux client ..."
	insinto "${GAMES_DATADIR}"/quake3/missionpack
	doins missionpack/*.pk3 || die "missionpack"
	insinto "${GAMES_DATADIR}"/quake3/baseq3
	doins baseq3/*.pk3 || die "baseq3"
	eend 0

	if use cdinstall ; then
		einfo "Copying files from CD ..."
		doins "${CDROM_ROOT}/${CDROM_MATCH}" || die "cdrom pak0"
		eend 0
	fi

	find "${D}" -exec touch '{}' \;

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	if ! use cdinstall ; then
		echo
		einfo "You need to copy pak0.pk3 from your Quake3 CD into ${dir}/baseq3."
		einfo "Or if you have got a Window installation of Q3 make a symlink to save space."
		echo
		einfo "Or, re-emerge quake3-data with USE=cdinstall."
		echo
	fi
}
