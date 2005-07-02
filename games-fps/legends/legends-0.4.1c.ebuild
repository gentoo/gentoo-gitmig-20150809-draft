# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/legends/legends-0.4.1c.ebuild,v 1.3 2005/07/02 16:54:32 herbs Exp $

inherit games

MY_P=${PN}_linux-${PV}
DESCRIPTION="A fast-paced first-person-perspective online multiplayer game similar to Tribes"
HOMEPAGE="http://legendsthegame.net/"
SRC_URI="http://www.legendsthegame.net/files//${MY_P}.tar.gz"

RESTRICT="nomirror"
KEYWORDS="-* ~amd64 x86"
LICENSE="as-is"
SLOT="0"
IUSE="dedicated"

DEPEND=""
RDEPEND=">=media-libs/libsdl-1.2
	media-libs/libogg
	media-libs/libvorbis
	media-libs/openal
	amd64? ( >=app-emulation/emul-linux-x86-sdl-2.1
			>=app-emulation/emul-linux-x86-soundlibs-2.1 )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	local LIBSDL=libSDL-1.3.so.0

	unpack ${A}
	cd "${S}"
	# keep libSDL-1.3.so because legends requires it as of 0.4.0, and
	# 1.2.6 is highest in portage
	# rm libSDL-*.so*
	rm runlegends libSDL-1.2.so.0 libopenal.so libogg.so.0 libvorbis.so.0
	find . -type f -exec chmod a-x '{}' \;
	chmod a+x lindedicated LinLegends
	cp "${FILESDIR}"/legends{,-ded} "${T}" || die "cp failed"
	sed -i \
		-e "s:GENTOO_DIR:${GAMES_PREFIX_OPT}/${PN}:" \
		-e "s:LIBSDL:${LIBSDL}:" \
		"${T}"/legends{,-ded} \
		|| die "sed failed"
}

src_install() {
	local dir="${GAMES_PREFIX_OPT}/${PN}"

	dogamesbin "${T}/legends" || die "dogamesbin failed (1)"
	keepdir "${dir}/"{show/ui,show/scripts,legends/scripts,legends/data,common/server,common/edit,common/client}
	cp -R * "${D}${dir}/" || die "cp failed"
	if use dedicated ; then
		dogamesbin "${T}"/legends-ded || die "dogamesbin failed (2)"
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
