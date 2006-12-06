# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/gorky17-demo/gorky17-demo-1.0.0.ebuild,v 1.3 2006/12/06 20:39:17 wolf31o2 Exp $

inherit eutils games

MY_PN="gorky17"

DESCRIPTION="Horror conspiracy game mixing elements of strategy and role-playing"
HOMEPAGE="http://www.linuxgamepublishing.com/info.php?id=gorky17"
SRC_URI="http://demofiles.linuxgamepublishing.com/${MY_PN}/${MY_PN}_demo.run"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="strip"

RDEPEND="media-libs/alsa-lib
	x86? (
		media-libs/libsdl
		sys-libs/zlib
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXdmcp
		x11-libs/libXext )
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-soundlibs
		app-emulation/emul-linux-x86-sdl )"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

QA_EXECSTACK="${dir:1}/gorky17_demo ${dir:1}/gorky17_demo.dynamic"

src_unpack() {
	unpack_makeself
	unpack ./data/data.tar.gz
	rm -r data lgp_* setup* bin/{Linux/*64,*BSD}
}

src_install() {
	exeinto "${dir}"
	doexe bin/Linux/x86/${MY_PN}* || die "doexe failed"

	insinto "${dir}"
	doins -r * || die "doins -r failed"
	rm -r "${Ddir}"/bin

	# gorky17_demo.dynamic has crackling audio,
	# so let's use the static binary instead.
	games_make_wrapper ${PN} ./${MY_PN}_demo "${dir}"
	newicon icon.xpm ${PN}.xpm
	make_desktop_entry ${PN} "Gorky 17 (Demo)" ${PN}.xpm

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	einfo "The instruction manual is available as:"
	einfo "   http://demofiles.linuxgamepublishing.com/gorky17/manual.pdf"
	echo
}
