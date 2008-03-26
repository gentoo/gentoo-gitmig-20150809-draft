# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/freedoom/freedoom-0.6.2.ebuild,v 1.1 2008/03/26 07:22:02 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="Freedoom - Open Source Doom resources"
HOMEPAGE="http://freedoom.sourceforge.net/"
SRC_URI="mirror://sourceforge/freedoom/freedoom-demo-${PV}.zip
	mirror://sourceforge/freedoom/freedoom-iwad-${PV}.zip
	mirror://sourceforge/freedoom/freedm-${PV}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doomsday"

RDEPEND="doomsday? ( games-fps/doomsday )"
DEPEND="app-arch/unzip"

S=${WORKDIR}

src_install() {
	insinto "${GAMES_DATADIR}"/doom-data/${PN}
	doins */*.wad || die "doins wad"
	dodoc freedoom-iwad-${PV}/{CREDITS,ChangeLog,NEWS,README}
	if use doomsday; then
		# Make wrapper for doomsday
		games_make_wrapper doomsday-freedoom "jdoom -file \
			${GAMES_DATADIR}/doom-data/freedoom/*.wad"
		make_desktop_entry doomsday-freedoom "Doomsday - Freedoom"
	fi
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	if use doomsday; then
		elog "To use the doomsday engine, run doomsday-freedoom"
	else
		elog "A Doom engine is required to play the wad"
		elog "Enable the doomsday use flag if you want to use the doomsday engine"
	fi
	echo
	ewarn "To play freedoom with Doom engines which do not support"
	ewarn "subdirectories, create symlinks by running the following:"
	ewarn "(Be careful of overwriting existing wads.)"
	ewarn
	ewarn "   cd ${GAMES_DATADIR}/doom-data"
	ewarn "   for f in doom{1,2} freedm ; do"
	ewarn "       ln -sn freedoom/\${f}.wad"
	ewarn "   done"
}
