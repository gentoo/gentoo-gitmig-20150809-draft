# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/x2-demo/x2-demo-1.4.01.ebuild,v 1.2 2006/12/06 21:09:36 wolf31o2 Exp $

# The comments are in this ebuild in case upstream ever decides to make another
# patch, we already have all the code.  Blame Paul Bredbury <brebs@sent.com> for
# writing it all.  *grin*

#inherit eutils versionator games
inherit eutils games

#PV_MAJOR=$(get_version_component_range 1-2)
#MY_P=${PN}-${PV_MAJOR}-${PV}

DESCRIPTION="Open-ended space opera with trading, building & fighting"
HOMEPAGE="http://www.linuxgamepublishing.com/info.php?id=x2"

# Patches are in http://updatefiles.linuxgamepublishing.com/x2-demo/
SRC_URI="http://demofiles.linuxgamepublishing.com/x2/${PN}.run"
#	http://updatefiles.linuxgamepublishing.com/${PN}/${MY_P}-x86.run"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="strip"

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
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-soundlibs
		app-emulation/emul-linux-x86-sdl
		app-emulation/emul-linux-x86-gtklibs )"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

src_unpack() {
	unpack_makeself ${PN}.run
#	unpack_makeself ${MY_P}-x86.run
	unpack ./data.tar.gz
	rm -r data.tar.gz lgp_* setup*
}

src_install() {
	exeinto "${dir}"
	doexe bin/Linux/x86/x2* || die "doins exes"

	insinto "${dir}"
	doins -r * || die "doins -r failed"

#	bin/Linux/x86/loki_patch patch.dat ${Ddir} || die "loki_patch failed"
#	loki_patch patch.dat ${Ddir} || die "loki_patch failed"

	keepdir "${dir}"/database
	rm -f "${Ddir}"/bin

	# x2_demo.dynamic continually moans about "SIGABRT caught",
	# so let's use the static binary instead.
	games_make_wrapper ${PN} ./x2_demo "${dir}" "${dir}"
	newicon icon.xpm ${PN}.xpm
	make_desktop_entry ${PN} "X2 - The Threat (Demo)" ${PN}.xpm

	prepgamesdirs
}
