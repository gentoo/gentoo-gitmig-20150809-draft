# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/legends/legends-0.4.0.ebuild,v 1.1 2004/02/10 10:35:29 mr_bones_ Exp $

inherit games

DESCRIPTION="A fast-paced first-person-perspective online multiplayer game similar to Tribes"
HOMEPAGE="http://hosted.tribalwar.com/legends/"
SRC_URI="http://hosted.tribalwar.com/legends/files/${P}.tar.gz"

RESTRICT="nomirror"
KEYWORDS="-* x86"
LICENSE="as-is"
SLOT="0"
IUSE="dedicated"

DEPEND=""
RDEPEND=">=media-libs/libsdl-1.2
	media-libs/openal"

src_unpack() {
	unpack ${A}
	cd ${S}
	# keep libSDL-1.3.so because legends requires it as of 0.4.0, and
	# 1.2.6 is highest in portage
	# rm libSDL-*.so*
	rm runlegends libopenal.so
	find . -type f -exec chmod a-x '{}' \;
	chmod a+x lindedicated LinLegends
}

src_install() {
	local dir="${GAMES_PREFIX_OPT}/${PN}"
	local LIBSDL=libSDL-1.3.so.0

	dodir "${dir}"
	keepdir "${dir}/"{show/ui,show/scripts,legends/scripts,legends/data,common/server,common/edit,common/client}
	cp -R * "${D}${dir}/" || die "cp failed"
	dogamesbin "${FILESDIR}/legends" || die "dogamesbin failed (1)"
	dosed "s:GENTOO_DIR:${dir}:" "${GAMES_BINDIR}/legends"
	dosed "s:LIBSDL:${LIBSDL}:" "${GAMES_BINDIR}/legends"
	if [ `use dedicated` ] ; then
		dogamesbin "${FILESDIR}/legends-ded" || die "dogamesbin failed (2)"
		dosed "s:GENTOO_DIR:${dir}:" "${GAMES_BINDIR}/legends-ded"
	fi
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "Version ${PV} of ${PN} may give problems if there are"
	einfo "config-files from earlier versions.  Removing the ~/.legends dir"
	einfo "and restarting will solve this."
	echo
}
