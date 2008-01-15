# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/openarena/openarena-0.7.1.ebuild,v 1.3 2008/01/15 09:31:15 nyhm Exp $

inherit eutils versionator games

MY_PV=$(delete_all_version_separators)

DESCRIPTION="Open-source replacement for Quake 3 Arena"
HOMEPAGE="http://openarena.ws/"
SRC_URI="http://download.tuxfamily.net/cooker/openarena/rel070/oa070.zip
	oa${MY_PV}-patch.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated"
RESTRICT="fetch strip"

RDEPEND="virtual/opengl
	media-libs/openal
	media-libs/libsdl
	x11-libs/libXext
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp"
DEPEND="app-arch/unzip"

S=${WORKDIR}/openarena-0.7.0

dir=${GAMES_PREFIX_OPT}/${PN}

pkg_nofetch() {
	einfo "Please download ${A} from:"
	einfo "  ${HOMEPAGE}"
	einfo "and move them to ${DISTDIR}"
	echo
}

src_install() {
	local arch="i386" ded_exe="ioq3ded" exe="ioquake3"
	use amd64 && arch="x86_64"

	ded_exe="${ded_exe}.${arch}"

	exeinto "${dir}"
	doexe "${exe}"*."${arch}" || die
	if use dedicated ; then
		doexe "${ded_exe}" || die
		games_make_wrapper ${PN}-ded "./${ded_exe}" "${dir}"
	fi

	insinto "${dir}"
	doins -r baseoa || die
	doins CHANGES CREDITS LINUXNOTES README || die

	games_make_wrapper ${PN} "./${exe}.${arch}" "${dir}"
	doicon "${FILESDIR}"/openarena.xpm
	make_desktop_entry ${PN} "Open Arena" openarena.xpm

	prepgamesdirs
}
