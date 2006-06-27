# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake1-data/quake1-data-2.40.ebuild,v 1.8 2006/06/27 19:54:48 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="iD Software's Quake 1 ... the data files"
HOMEPAGE="http://www.idsoftware.com/games/quake/quake/"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="app-arch/lha"
RDEPEND=""

S=${WORKDIR}

pkg_setup() {
	games_pkg_setup

	if built_with_use "games-fps/quake1-demodata" symlink ; then
		eerror "The symlink for the demo data conflicts with the cdinstall data"
		die "Unmerge games-fps/quake1-demodata to remove the conflict"
	fi

	export CDROM_SET_NAMES=("Existing Install" "Quake CD" "Ultimate Quake Collection")
	cdrom_get_cds id1:q101_int.1:Setup/ID1
}

src_unpack() {
	echo ">>> Unpacking q101_int to ${PWD}"
	if [[ ${CDROM_SET} == "1" ]] ; then
		cat "${CDROM_ROOT}"/q101_int.1 "${CDROM_ROOT}"/q101_int.2 > \
			"${S}"/q101_int.exe
		lha xqf "${S}"/q101_int.exe || die "failure unpacking q101_int.exe"
		rm -f q101_int.exe
	fi
}

src_install() {
	insinto ${GAMES_DATADIR}/quake1/id1
	case ${CDROM_SET} in
		0)  doins "${CDROM_ROOT}"/id1/* || die "doins pak files"
		    dodoc "${CDROM_ROOT}"/*.txt
		    ;;
		1)  doins id1/* || die "doins pak files"
		    dodoc *.txt
		    ;;
		2)  newins "${CDROM_ROOT}"/Setup/ID1/PAK0.PAK pak0.pak \
				|| die "ins pak0.pak failed"
		    newins "${CDROM_ROOT}"/Setup/ID1/PAK1.PAK pak1.pak \
				|| die "ins pak1.pak failed"
		    dodoc "${CDROM_ROOT}"/Docs/*
		    ;;
	esac
	prepgamesdirs
}
