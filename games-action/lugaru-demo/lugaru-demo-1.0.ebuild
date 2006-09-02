# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/lugaru-demo/lugaru-demo-1.0.ebuild,v 1.6 2006/09/02 23:53:04 mr_bones_ Exp $

inherit games

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
		|| (
			(
				x11-libs/libX11
				x11-libs/libXext )
			virtual/x11 )
		=virtual/libstdc++-3.3 )"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	unpack_makeself lugaru-linux-x86-${PV}.run
	tar xpf lugaru-linux-x86.tar || die "executables unpacking failed"
	tar xpf lugaru-data.tar || die "data unpacking failed"
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/lugaru

	insinto "${dir}"
	doins -r Data Readme README.linux Screenshots Troubleshooting || die "doins"

	exeinto "${dir}"
	doexe lugaru-bin *.so *.so.0 || die "doexe"
	games_make_wrapper lugaru ./lugaru-bin "${dir}" "${dir}"

	doicon lugaru.xpm
	make_desktop_entry lugaru "Lugaru" lugaru.xpm

	prepgamesdirs
}
