# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/lugaru-demo/lugaru-demo-1.0.ebuild,v 1.7 2006/09/28 14:46:26 nyhm Exp $

inherit eutils games

DESCRIPTION="3D arcade with unique fighting system and antropomorphic characters"
HOMEPAGE="http://wolfire.com/lugaru.html"
SRC_URI="http://www.wolfiles.com/lugaru-linux-x86-${PV}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="strip"
QA_TEXTRELS="${GAMES_PREFIX_OPT:1}/lugaru/libSDL-1.2.so.0"
QA_EXECSTACK="${GAMES_PREFIX_OPT:1}/lugaru/lugaru-bin"

DEPEND="app-arch/unzip"

RDEPEND="sys-libs/glibc
	amd64? (
		app-emulation/emul-linux-x86-compat
		app-emulation/emul-linux-x86-sdl
		app-emulation/emul-linux-x86-xlibs )
	x86? (
		x11-libs/libX11
		x11-libs/libXext
		=virtual/libstdc++-3.3 )"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	unpack_makeself *.run
	unpack ./*.tar

	# Duplicate file and can't be handled by portage, bug #14983
	rm -f "Data/Textures/Quit.png "
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/lugaru

	insinto "${dir}"
	doins -r Data Readme README.linux Troubleshooting || die "doins"

	exeinto "${dir}"
	doexe lugaru-bin *.so *.so.0 || die "doexe"
	games_make_wrapper lugaru ./lugaru-bin "${dir}" "${dir}"

	doicon lugaru.xpm
	make_desktop_entry lugaru "Lugaru" lugaru.xpm

	prepgamesdirs
}
