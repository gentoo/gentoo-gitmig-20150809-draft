# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/x2-demo/x2-demo-1.4.03.ebuild,v 1.1 2006/12/12 18:24:13 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="Open-ended space opera with trading, building & fighting"
HOMEPAGE="http://www.linuxgamepublishing.com/info.php?id=x2"

# Patches are in http://updatefiles.linuxgamepublishing.com/x2-demo/
# Unversioned filename, grrr (is pre-patched).
SRC_URI="http://demofiles.linuxgamepublishing.com/x2/${PN}.run"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror primaryuri strip"

RDEPEND="media-libs/alsa-lib
	sys-libs/glibc
	x86? (
		media-libs/libsdl
		media-libs/openal
		sys-libs/zlib
		x11-libs/gtk+
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXdmcp
		x11-libs/libXext
		x11-libs/libXi )
	amd64? (
		app-emulation/emul-linux-x86-gtklibs
		app-emulation/emul-linux-x86-sdl )"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

src_unpack() {
	unpack_makeself ${PN}.run
	unpack ./data.tar.gz
	rm -rf data.tar.gz lgp_* setup*

	# Prevents e.g. "cp: omitting directory bin/OpenBSD" warnings
	rm -f bin/*{BSD,64} bin/Linux/*64
}

src_install() {
	exeinto "${dir}"
	doexe bin/Linux/x86/x2_demo{,.dynamic} || die "doexe x2"

	insinto "${dir}"
	doins -r * || die "doins -r failed"

	keepdir "${dir}"/database
	rm -rf "${Ddir}"/bin

	# We don't support the dynamic version, even though we install it.
	games_make_wrapper ${PN} ./x2_demo "${dir}" "${dir}"
	newicon icon.xpm ${PN}.xpm || die "newicon failed"
	make_desktop_entry ${PN} "X2 - The Threat (Demo)" ${PN}.xpm

	prepgamesdirs
}
