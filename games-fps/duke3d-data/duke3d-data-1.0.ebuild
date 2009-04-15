# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/duke3d-data/duke3d-data-1.0.ebuild,v 1.2 2009/04/15 23:22:57 nyhm Exp $

inherit eutils games

DESCRIPTION="Duke Nukem 3D data files"
HOMEPAGE="http://www.3drealms.com/"
SRC_URI=""

LICENSE="DUKE3D"
SLOT="0"
KEYWORDS="~hppa ~ppc ~x86"
IUSE=""
PROPERTIES="interactive"

DEPEND=""
RDEPEND="games-fps/duke3d"

S=${WORKDIR}

src_unpack() {
	export CDROM_NAME_SET=("Existing Install" "Duke Nukem 3D CD")
	cdrom_get_cds duke3d.grp:dvd/dn3dinst/duke3d.grp

	if [[ ${CDROM_SET} -ne 0 && ${CDROM_SET} -ne 1 ]] ; then
		die "Error locating data files.";
	fi
}

src_install() {
	local DATAROOT

	case ${CDROM_SET} in
	0) DATAROOT= ;;
	1) DATAROOT="dn3dinst/" ;;
	esac

	insinto "${GAMES_DATADIR}"/duke3d
	doins "${CDROM_ROOT}"/$DATAROOT/{duke3d.grp,duke.rts,game.con,user.con,demo2.dmo,defs.con,demo1.dmo} \
		|| die "doins failed"
	prepgamesdirs
}
