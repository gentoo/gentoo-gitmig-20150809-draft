# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/legends/legends-0.4.1b.ebuild,v 1.2 2004/12/04 17:53:10 wolf31o2 Exp $

inherit games

DESCRIPTION="A fast-paced first-person-perspective online multiplayer game similar to Tribes"
HOMEPAGE="http://epsilon.serverseed.com/~legends/"
SRC_URI="http://hosted.tribalwar.com/legends/files/${P}.tar.gz"

RESTRICT="nomirror"
KEYWORDS="-* x86"
LICENSE="as-is"
SLOT="0"
IUSE="dedicated"

DEPEND=""
RDEPEND=">=media-libs/libsdl-1.2
	media-libs/openal"

S="${S}/${P}" # Nice packing job guys.

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

	keepdir "${dir}/"{show/ui,show/scripts,legends/scripts,legends/data,common/server,common/edit,common/client}
	cp -R * "${D}${dir}/" || die "cp failed"
	dogamesbin "${FILESDIR}/legends" || die "dogamesbin failed (1)"
	sed -i \
		-e "s:GENTOO_DIR:${dir}:" \
		-e "s:LIBSDL:${LIBSDL}:" "${D}${GAMES_BINDIR}/legends" \
		|| die "sed failed"
	if use dedicated ; then
		dogamesbin "${FILESDIR}/legends-ded" || die "dogamesbin failed (2)"
		sed -i \
			-e "s:GENTOO_DIR:${dir}:" "${D}${GAMES_BINDIR}/legends-ded" \
			|| die "sed failed"
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
