# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/legends/legends-0.4.1.39.ebuild,v 1.1 2006/04/20 01:07:54 wolf31o2 Exp $

inherit games

MY_P=${PN}_linux_${PV}
DESCRIPTION="A fast-paced first-person-perspective online multiplayer game similar to Tribes"
HOMEPAGE="http://legendsthegame.net/"
SRC_URI="http://www.legendsthegame.net/files/${MY_P}.sh
	mirror://gentoo/${PN}.png
	http://dev.gentoo.org/~wolf31o2/sources/dump/${PN}.png"

RESTRICT="mirror"
KEYWORDS="-* ~amd64 ~x86"
LICENSE="as-is"
SLOT="0"
IUSE="dedicated"

DEPEND=""
RDEPEND=">=media-libs/libsdl-1.2
	media-libs/libogg
	media-libs/libvorbis
	media-libs/openal
	amd64? ( >=app-emulation/emul-linux-x86-sdl-2.1
			>=app-emulation/emul-linux-x86-soundlibs-2.1 )
	|| (
		media-fonts/font-adobe-75dpi
		virtual/x11 )"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

src_unpack() {
	local LIBSDL=libSDL-1.3.so.0
	SKIP=$(awk '/^__ARCHIVE_FOLLOWS__/ { print NR + 1; exit 0; }' \
		${DISTDIR}/${MY_P}.sh)
	tail -n +${SKIP} ${DISTDIR}/${MY_P}.sh | tar -C ${WORKDIR} -xjf - \
		|| die "unpacking"

	cd "${S}"
	# keep libSDL-1.3.so because legends requires it as of 0.4.0, and
	# 1.2.6 is highest in portage
	# rm libSDL-*.so*
	rm runlegends libSDL-1.2.so.0 libopenal.so libogg.so.0 libvorbis.so.0 *.DLL
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
	cd "${S}"
	dogamesbin "${T}/legends" || die "dogamesbin failed (1)"
	keepdir "${dir}/"{show/ui,show/scripts,legends/scripts,legends/data,common/server,common/edit,common/client}
	cp -rPp * "${Ddir}/" || die "cp failed"
	if use dedicated ; then
		dogamesbin "${T}"/legends-ded || die "dogamesbin failed (2)"
	fi
	doicon "${DISTDIR}"/${PN}.png
	make_desktop_entry legends "Legends"
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
