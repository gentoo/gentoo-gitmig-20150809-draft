# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake2-data/quake2-data-3.20.ebuild,v 1.15 2005/10/31 23:03:45 vapier Exp $

inherit eutils games

DESCRIPTION="iD Software's Quake 2 ... the data files"
HOMEPAGE="http://www.idsoftware.com/"
SRC_URI="ftp://ftp.idsoftware.com/idstuff/quake2/q2-${PV}-x86-full-ctf.exe"

LICENSE="Q2EULA"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="videos"

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}

pkg_setup() {
	export CDROM_SET_NAMES=("Existing Install" "Quake2 CD" "Quake4 Bonus DVD")
	cdrom_get_cds baseq2:Install:Movies
	games_pkg_setup
}

src_unpack() {
	# The .exe is just a self-extracting .zip
	echo ">>> Unpacking ${A} to ${PWD}"
	unzip -qo "${DISTDIR}/${A}" || die "Failed to unpack ${A}"
}

src_install() {
	dodoc DOCS/* 3.20_Changes.txt
	newdoc ctf/readme.txt ctf-readme.txt
	case ${CDROM_SET} in
		0|1) dohtml -r "${CDROM_ROOT}"/DOCS/quake2_manual/* ;;
		2)   dodoc "${CDROM_ROOT}"/Docs/* ;;
	esac

	local baseq2_cdpath
	case ${CDROM_SET} in
		0|1) baseq2_cdpath=${CDROM_ROOT}/baseq2;;
		2)   baseq2_cdpath=${CDROM_ROOT}/setup/Data/baseq2;;
	esac

	dodir ${GAMES_DATADIR}/quake2/baseq2

	if use videos ; then
		insinto ${GAMES_DATADIR}/quake2/baseq2/video
		doins "${baseq2_cdpath}"/video/* || die "doins videos"
	fi

	insinto ${GAMES_DATADIR}/quake2/baseq2
	doins "${baseq2_cdpath}"/pak0.pak || die "couldnt grab pak0.pak"
	doins baseq2/*.pak || die "couldnt grab release paks"
	doins baseq2/maps.lst || die "couldnt grab maps.lst"
	cp -R baseq2/players "${D}/${GAMES_DATADIR}"/quake2/baseq2/ || die "couldnt grab player models"

	insinto "${GAMES_DATADIR}"/quake2/ctf
	doins ctf/*.{cfg,ico,pak} || die "couldnt grab ctf"

	prepgamesdirs
}
